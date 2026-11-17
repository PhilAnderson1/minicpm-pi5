// Copyright (C) 2024 Iwan Kawrakow
// Copyright (C) 2026 PhilAnderson1
// MIT license; SPDX-License-Identifier: MIT
// Derived from the Q4_K_R4 eight-token ARM kernel.
#include "iqk_config.h"
#if defined(IQK_IMPLEMENT) && defined(__aarch64__)
#include "iqk_gemm_kquants.h"
#include "iqk_q4_reuse.h"

namespace {

IQK_ALWAYS_INLINE void prepare_q4_k_quants(const uint8x16_t& m4, const uint8x16x4_t& bits, int8x16_t * qx) {
    qx[0] = vandq_u8(bits.val[0], m4);   //  0...3 from the 4 rows
    qx[1] = vandq_u8(bits.val[1], m4);   // 16..19
    qx[2] = vandq_u8(bits.val[2], m4);   //  4...7
    qx[3] = vandq_u8(bits.val[3], m4);   // 20..23
    qx[4] = vshrq_n_u8(bits.val[0], 4);  //  8..11
    qx[5] = vshrq_n_u8(bits.val[1], 4);  // 24..27
    qx[6] = vshrq_n_u8(bits.val[2], 4);  // 12..15
    qx[7] = vshrq_n_u8(bits.val[3], 4);  // 28..31
}


struct alignas(16) Q4Scales {
    float32x4_t d;
    float32x4_t mins[8];
    int32x4_t scales[8];
};
struct alignas(16) PreparedQ4Block {
    Q4Scales meta;
    int8x16_t qs[8][8];
};
IQK_NOINLINE void prepare_q4_tile(int n, const void * vx, PreparedQ4Block * expanded) {
    auto w=(const block_q4_k_r4*)vx;
    auto mf=vdupq_n_u8(15),m3=vdupq_n_u8(0x30);
    for(int b=0;b<n/256;b++) {
        auto &o=expanded[b].meta;
        o.d=vcvt_f32_f16(vld1_f16((const float16_t*)w[b].d));
        auto m=vmulq_f32(vcvt_f32_f16(vld1_f16((const float16_t*)w[b].d+4)),vdupq_n_f32(-1.f));
        auto sl=vld1q_u8_x2(w[b].scales_l);auto sh=vld1q_u8(w[b].scales_h);
        int8x16x2_t mins,scales;
        mins.val[0]=vorrq_u8(vshrq_n_u8(sl.val[0],4),vandq_u8(vshlq_n_u8(sh,2),m3));
        mins.val[1]=vorrq_u8(vshrq_n_u8(sl.val[1],4),vandq_u8(vshrq_n_u8(sh,2),m3));
        scales.val[0]=vorrq_u8(vandq_u8(sl.val[0],mf),vandq_u8(vshlq_n_u8(sh,4),m3));
        scales.val[1]=vorrq_u8(vandq_u8(sl.val[1],mf),vandq_u8(sh,m3));
        for(int i=0;i<2;i++) {
            auto ml=vmovl_s8(vget_low_s8(mins.val[i])),mh=vmovl_s8(vget_high_s8(mins.val[i]));
            o.mins[4*i]=vmulq_f32(m,vcvtq_f32_s32(vmovl_s16(vget_low_s16(ml))));
            o.mins[4*i+1]=vmulq_f32(m,vcvtq_f32_s32(vmovl_s16(vget_high_s16(ml))));
            o.mins[4*i+2]=vmulq_f32(m,vcvtq_f32_s32(vmovl_s16(vget_low_s16(mh))));
            o.mins[4*i+3]=vmulq_f32(m,vcvtq_f32_s32(vmovl_s16(vget_high_s16(mh))));
            auto l=vmovl_s8(vget_low_s8(scales.val[i])),h=vmovl_s8(vget_high_s8(scales.val[i]));
            o.scales[4*i]=vmovl_s16(vget_low_s16(l));o.scales[4*i+1]=vmovl_s16(vget_high_s16(l));
            o.scales[4*i+2]=vmovl_s16(vget_low_s16(h));o.scales[4*i+3]=vmovl_s16(vget_high_s16(h));
            for(int j=0;j<4;j++)prepare_q4_k_quants(mf,vld1q_u8_x4(w[b].qs+256*i+64*j),expanded[b].qs[4*i+j]);
        }
    }
}
IQK_NOINLINE void multiply_prepared_q4(int n, const DataInfo& info, const PreparedQ4Block * expanded) {
    constexpr int nrc_y=8;

    Q8<nrc_y, block_q8_K> q8(info);
    int nbl = n / QK_K;
    int8x16_t qx[8];
    int32x4x4_t scales;
    float32x4_t acc[nrc_y] = {};
    {
        constexpr int ix = 0;
        for (int ibl = 0; ibl < nbl; ++ibl) {
            const auto & prepared=expanded[ibl].meta;
            auto d4=prepared.d;
            for(int is=0;is<2;is++) {
                float32x4x4_t fscales;
                for(int j=0;j<4;j++)fscales.val[j]=prepared.mins[4*is+j];
                for (int iy = 0; iy < nrc_y; ++iy) {
                    auto m8 = vld1q_f32((const float *)q8.y[iy][ibl].bsums + 4*is);
                    acc[iy] = vmlaq_laneq_f32(acc[iy], fscales.val[0], m8, 0);
                    acc[iy] = vmlaq_laneq_f32(acc[iy], fscales.val[1], m8, 1);
                    acc[iy] = vmlaq_laneq_f32(acc[iy], fscales.val[2], m8, 2);
                    acc[iy] = vmlaq_laneq_f32(acc[iy], fscales.val[3], m8, 3);
                }
            }
            int32x4_t isum[nrc_y] = {};
            for(int is=0;is<2;is++) {
                for(int j=0;j<4;j++)scales.val[j]=prepared.scales[4*is+j];
                for (int ib = 0; ib < 4; ++ib) {
                    for(int j=0;j<8;j++)qx[j]=expanded[ibl].qs[4*is+ib][j];
                    for (int iy = 0; iy < nrc_y; ++iy) {
                        auto y = vld1q_s8_x2(q8.y[iy][ibl].qs+128*is+32*ib);
                        auto sumi = interleaved_dotq(qx, y);
                        isum[iy] = vmlaq_s32(isum[iy], scales.val[ib], sumi);
                    }
                }
            }
            for (int iy = 0; iy < nrc_y; ++iy) {
                acc[iy] = vfmaq_f32(acc[iy], vmulq_f32(d4, vdupq_n_f32(q8.scale(iy, ibl))), vcvtq_f32_s32(isum[iy]));
            }
        }
        for (int iy = 0; iy < nrc_y; ++iy) {
            info.store(ix, iy, acc[iy]);
            acc[iy] = vdupq_n_f32(0.f);
        }
    }
}


// 24 blocks cover four output rows with 6144 input elements, not the whole model.
static_assert(sizeof(PreparedQ4Block) == 1296, "prepared Q4 block size");
} // namespace

void iqk_q4_reuse(int n, const void * vx, size_t bx, const DataInfo& info, int nrc_x, int batch) {
    GGML_ASSERT((n == 2048 || n == 6144) && nrc_x % 4 == 0);
    GGML_ASSERT(batch > 0 && batch <= 128 && batch % 8 == 0 && !info.row_mapping);
    alignas(64) thread_local PreparedQ4Block expanded[24];
    for (int ix = 0; ix < nrc_x; ix += 4) {
        prepare_q4_tile(n, (const char *)vx + ix*bx, expanded);
        for (int iy = 0; iy < batch; iy += 8) {
            auto local = info;
            local.s += ix;
            local.cur_y += iy;
            multiply_prepared_q4(n, local, expanded);
        }
    }
}
#endif
