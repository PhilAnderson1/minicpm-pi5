// Copyright (C) 2026 PhilAnderson1
// SPDX-License-Identifier: MIT
#include "iqk/iqk_config.h"
#include "iqk_fa_128_decode.h"
#if defined(__aarch64__) && defined(IQK_IMPLEMENT) && defined(GGML_IQK_FLASH_ATTENTION)
#include "iqk/fa/iqk_fa_templates.h"

// Keep four heads x 32 outputs in registers across each 128-key block.
// Retain FP16 FMA order and block rescaling. Keep this helper out of line
// to avoid accumulator spills in the attention driver.
static IQK_NOINLINE void decode_values(float16_t *qkv_cache,const HelperF16& vh,const FlashMS<4,128>& fms){
    constexpr int D=128,q_step=4;
    for (int j = 0; j < q_step; ++j) {
        auto R = qkv_cache + D*j;
        if (fms.need_scaling[j] == 2) {
            std::memset(R, 0, D*sizeof(float16_t));
        } else if (fms.need_scaling[j] == 1) {
            auto vms = F16::set1(fms.vms[j]);
            for (int i = 0; i < D/F16::block_size; ++i) {
                F16::store(R + F16::block_size*i,
                F16::mul(vms, F16::load(R + F16::block_size*i)));
            }
        }
    }
    // One tile stays in registers for the complete key block.
    for(int j=0;j<4;j+=4)for(int i=0;i<16;i+=4){
        auto a0_0=vld1q_f16(qkv_cache+128*(j+0)+8*(i+0));
        auto a0_1=vld1q_f16(qkv_cache+128*(j+0)+8*(i+1));
        auto a0_2=vld1q_f16(qkv_cache+128*(j+0)+8*(i+2));
        auto a0_3=vld1q_f16(qkv_cache+128*(j+0)+8*(i+3));
        auto a1_0=vld1q_f16(qkv_cache+128*(j+1)+8*(i+0));
        auto a1_1=vld1q_f16(qkv_cache+128*(j+1)+8*(i+1));
        auto a1_2=vld1q_f16(qkv_cache+128*(j+1)+8*(i+2));
        auto a1_3=vld1q_f16(qkv_cache+128*(j+1)+8*(i+3));
        auto a2_0=vld1q_f16(qkv_cache+128*(j+2)+8*(i+0));
        auto a2_1=vld1q_f16(qkv_cache+128*(j+2)+8*(i+1));
        auto a2_2=vld1q_f16(qkv_cache+128*(j+2)+8*(i+2));
        auto a2_3=vld1q_f16(qkv_cache+128*(j+2)+8*(i+3));
        auto a3_0=vld1q_f16(qkv_cache+128*(j+3)+8*(i+0));
        auto a3_1=vld1q_f16(qkv_cache+128*(j+3)+8*(i+1));
        auto a3_2=vld1q_f16(qkv_cache+128*(j+3)+8*(i+2));
        auto a3_3=vld1q_f16(qkv_cache+128*(j+3)+8*(i+3));
        for(int l=0;l<128;l+=4){
            auto w0=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+0)+l));
            auto w1=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+1)+l));
            auto w2=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+2)+l));
            auto w3=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+3)+l));
            {
                F16::Data v0,v1;vh.load(l+0,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+0,i+2,v2,v3);
                a0_0=vfmaq_lane_f16(a0_0,v0,w0,0);
                a0_1=vfmaq_lane_f16(a0_1,v1,w0,0);
                a0_2=vfmaq_lane_f16(a0_2,v2,w0,0);
                a0_3=vfmaq_lane_f16(a0_3,v3,w0,0);
                a1_0=vfmaq_lane_f16(a1_0,v0,w1,0);
                a1_1=vfmaq_lane_f16(a1_1,v1,w1,0);
                a1_2=vfmaq_lane_f16(a1_2,v2,w1,0);
                a1_3=vfmaq_lane_f16(a1_3,v3,w1,0);
                a2_0=vfmaq_lane_f16(a2_0,v0,w2,0);
                a2_1=vfmaq_lane_f16(a2_1,v1,w2,0);
                a2_2=vfmaq_lane_f16(a2_2,v2,w2,0);
                a2_3=vfmaq_lane_f16(a2_3,v3,w2,0);
                a3_0=vfmaq_lane_f16(a3_0,v0,w3,0);
                a3_1=vfmaq_lane_f16(a3_1,v1,w3,0);
                a3_2=vfmaq_lane_f16(a3_2,v2,w3,0);
                a3_3=vfmaq_lane_f16(a3_3,v3,w3,0);
            }
            {
                F16::Data v0,v1;vh.load(l+1,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+1,i+2,v2,v3);
                a0_0=vfmaq_lane_f16(a0_0,v0,w0,1);
                a0_1=vfmaq_lane_f16(a0_1,v1,w0,1);
                a0_2=vfmaq_lane_f16(a0_2,v2,w0,1);
                a0_3=vfmaq_lane_f16(a0_3,v3,w0,1);
                a1_0=vfmaq_lane_f16(a1_0,v0,w1,1);
                a1_1=vfmaq_lane_f16(a1_1,v1,w1,1);
                a1_2=vfmaq_lane_f16(a1_2,v2,w1,1);
                a1_3=vfmaq_lane_f16(a1_3,v3,w1,1);
                a2_0=vfmaq_lane_f16(a2_0,v0,w2,1);
                a2_1=vfmaq_lane_f16(a2_1,v1,w2,1);
                a2_2=vfmaq_lane_f16(a2_2,v2,w2,1);
                a2_3=vfmaq_lane_f16(a2_3,v3,w2,1);
                a3_0=vfmaq_lane_f16(a3_0,v0,w3,1);
                a3_1=vfmaq_lane_f16(a3_1,v1,w3,1);
                a3_2=vfmaq_lane_f16(a3_2,v2,w3,1);
                a3_3=vfmaq_lane_f16(a3_3,v3,w3,1);
            }
            {
                F16::Data v0,v1;vh.load(l+2,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+2,i+2,v2,v3);
                a0_0=vfmaq_lane_f16(a0_0,v0,w0,2);
                a0_1=vfmaq_lane_f16(a0_1,v1,w0,2);
                a0_2=vfmaq_lane_f16(a0_2,v2,w0,2);
                a0_3=vfmaq_lane_f16(a0_3,v3,w0,2);
                a1_0=vfmaq_lane_f16(a1_0,v0,w1,2);
                a1_1=vfmaq_lane_f16(a1_1,v1,w1,2);
                a1_2=vfmaq_lane_f16(a1_2,v2,w1,2);
                a1_3=vfmaq_lane_f16(a1_3,v3,w1,2);
                a2_0=vfmaq_lane_f16(a2_0,v0,w2,2);
                a2_1=vfmaq_lane_f16(a2_1,v1,w2,2);
                a2_2=vfmaq_lane_f16(a2_2,v2,w2,2);
                a2_3=vfmaq_lane_f16(a2_3,v3,w2,2);
                a3_0=vfmaq_lane_f16(a3_0,v0,w3,2);
                a3_1=vfmaq_lane_f16(a3_1,v1,w3,2);
                a3_2=vfmaq_lane_f16(a3_2,v2,w3,2);
                a3_3=vfmaq_lane_f16(a3_3,v3,w3,2);
            }
            {
                F16::Data v0,v1;vh.load(l+3,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+3,i+2,v2,v3);
                a0_0=vfmaq_lane_f16(a0_0,v0,w0,3);
                a0_1=vfmaq_lane_f16(a0_1,v1,w0,3);
                a0_2=vfmaq_lane_f16(a0_2,v2,w0,3);
                a0_3=vfmaq_lane_f16(a0_3,v3,w0,3);
                a1_0=vfmaq_lane_f16(a1_0,v0,w1,3);
                a1_1=vfmaq_lane_f16(a1_1,v1,w1,3);
                a1_2=vfmaq_lane_f16(a1_2,v2,w1,3);
                a1_3=vfmaq_lane_f16(a1_3,v3,w1,3);
                a2_0=vfmaq_lane_f16(a2_0,v0,w2,3);
                a2_1=vfmaq_lane_f16(a2_1,v1,w2,3);
                a2_2=vfmaq_lane_f16(a2_2,v2,w2,3);
                a2_3=vfmaq_lane_f16(a2_3,v3,w2,3);
                a3_0=vfmaq_lane_f16(a3_0,v0,w3,3);
                a3_1=vfmaq_lane_f16(a3_1,v1,w3,3);
                a3_2=vfmaq_lane_f16(a3_2,v2,w3,3);
                a3_3=vfmaq_lane_f16(a3_3,v3,w3,3);
            }
        }
        vst1q_f16(qkv_cache+128*(j+0)+8*(i+0),a0_0);
        vst1q_f16(qkv_cache+128*(j+0)+8*(i+1),a0_1);
        vst1q_f16(qkv_cache+128*(j+0)+8*(i+2),a0_2);
        vst1q_f16(qkv_cache+128*(j+0)+8*(i+3),a0_3);
        vst1q_f16(qkv_cache+128*(j+1)+8*(i+0),a1_0);
        vst1q_f16(qkv_cache+128*(j+1)+8*(i+1),a1_1);
        vst1q_f16(qkv_cache+128*(j+1)+8*(i+2),a1_2);
        vst1q_f16(qkv_cache+128*(j+1)+8*(i+3),a1_3);
        vst1q_f16(qkv_cache+128*(j+2)+8*(i+0),a2_0);
        vst1q_f16(qkv_cache+128*(j+2)+8*(i+1),a2_1);
        vst1q_f16(qkv_cache+128*(j+2)+8*(i+2),a2_2);
        vst1q_f16(qkv_cache+128*(j+2)+8*(i+3),a2_3);
        vst1q_f16(qkv_cache+128*(j+3)+8*(i+0),a3_0);
        vst1q_f16(qkv_cache+128*(j+3)+8*(i+1),a3_1);
        vst1q_f16(qkv_cache+128*(j+3)+8*(i+2),a3_2);
        vst1q_f16(qkv_cache+128*(j+3)+8*(i+3),a3_3);
}}

void iqk_pi5_decode_128(int nk, int stride_q, int stride_k, int stride_v,
        const float * q, const char * k, const char * v,
        const ggml_fp16_t * mask, float scale, float * out, float * M, float * S) {
    FlashMS<4, 128> ms(scale, 0);
    FlashQKV<128, 4, 128> values;
    HelperF16 kh(k, stride_k), vh(v, stride_v);
    float16_t query[4*128];
    FlashQKfp32<128, 4, 128>::convert(4, stride_q/sizeof(float), q, query);
    ms.init_qstep();
    const int effective = mask_effective_nk1((const char *)mask, 4, 0, nk, 128);
    for (int key = 0; key < effective; key += 128) {
        DataInfo info{ms.cache, (const char *)query, 128, 256, 0, 1, nullptr};
        iqk_gemm_default_floats(128, 4, kh.block, kh.stride, info, 128);
        float32x4_t vk[32];
        for (int j = 0; j < 4; ++j) ms.update_M_S(j, vk, (const char *)(mask + key));
        decode_values(values.qkv_cache, vh, ms);
        kh.next_block(128);
        vh.next_block(128);
    }
    values.normalize_and_store(ms, 128, out, nullptr, 0, M, S);
}
#endif
