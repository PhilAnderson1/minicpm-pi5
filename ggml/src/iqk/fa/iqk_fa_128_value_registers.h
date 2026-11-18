// Copyright (C) 2026 PhilAnderson1
// SPDX-License-Identifier: MIT
// D128 Pi prefill: retain four queries x 32 outputs across 128 keys.
// Included only in iqk_fa_128_128.cpp, after the FP16 attention helpers.
// Named accumulators preserve register residency; per-output FMA order and
// Keep this helper out of line: inlining into the attention driver causes
// GCC to spill accumulators in the key loop.
// FP16 scaling/conversion match pi5_accumulate_values_128<64, 128>.
#ifdef __aarch64__
// GCC can expand lane intrinsics into DUP + vector FMLA. Keep weights in
// low SIMD registers and select the scalar lane directly, without broadcasts.
// The read/write accumulator preserves the original per-output key order.
template<int Lane>
static inline __attribute__((always_inline)) float16x8_t pi5_value_fma_lane(
        float16x8_t acc, float16x8_t value, float16x4_t weights) {
    static_assert(Lane >= 0 && Lane < 4);
    asm("fmla %0.8h, %1.8h, %2.h[%c3]"
        : "+w"(acc) : "w"(value), "x"(weights), "i"(Lane));
    return acc;
}

// The fused softmax path supplies weights already rounded to FP16. Retain
// the FP32-input instantiation for exact comparisons and existing callers.
template<bool HalfWeights = false>
IQK_NOINLINE void pi5_accumulate_values_registers_128(float16_t *qkv_cache,const HelperF16& vh,const FlashMS<64,128,true>& fms,
        const float16_t *weights = nullptr){
    constexpr int D=128,q_step=64;
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
    for(int j=0;j<64;j+=4)for(int i=0;i<16;i+=4){
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
            float16x4_t w0;
            if constexpr (HalfWeights) w0=vld1_f16(weights+128*(j+0)+l);
            else w0=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+0)+l));
            float16x4_t w1;
            if constexpr (HalfWeights) w1=vld1_f16(weights+128*(j+1)+l);
            else w1=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+1)+l));
            float16x4_t w2;
            if constexpr (HalfWeights) w2=vld1_f16(weights+128*(j+2)+l);
            else w2=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+2)+l));
            float16x4_t w3;
            if constexpr (HalfWeights) w3=vld1_f16(weights+128*(j+3)+l);
            else w3=vcvt_f16_f32(vld1q_f32(fms.cache+128*(j+3)+l));
            {
                F16::Data v0,v1;vh.load(l+0,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+0,i+2,v2,v3);
                a0_0=pi5_value_fma_lane<0>(a0_0,v0,w0);
                a0_1=pi5_value_fma_lane<0>(a0_1,v1,w0);
                a0_2=pi5_value_fma_lane<0>(a0_2,v2,w0);
                a0_3=pi5_value_fma_lane<0>(a0_3,v3,w0);
                a1_0=pi5_value_fma_lane<0>(a1_0,v0,w1);
                a1_1=pi5_value_fma_lane<0>(a1_1,v1,w1);
                a1_2=pi5_value_fma_lane<0>(a1_2,v2,w1);
                a1_3=pi5_value_fma_lane<0>(a1_3,v3,w1);
                a2_0=pi5_value_fma_lane<0>(a2_0,v0,w2);
                a2_1=pi5_value_fma_lane<0>(a2_1,v1,w2);
                a2_2=pi5_value_fma_lane<0>(a2_2,v2,w2);
                a2_3=pi5_value_fma_lane<0>(a2_3,v3,w2);
                a3_0=pi5_value_fma_lane<0>(a3_0,v0,w3);
                a3_1=pi5_value_fma_lane<0>(a3_1,v1,w3);
                a3_2=pi5_value_fma_lane<0>(a3_2,v2,w3);
                a3_3=pi5_value_fma_lane<0>(a3_3,v3,w3);
            }
            {
                F16::Data v0,v1;vh.load(l+1,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+1,i+2,v2,v3);
                a0_0=pi5_value_fma_lane<1>(a0_0,v0,w0);
                a0_1=pi5_value_fma_lane<1>(a0_1,v1,w0);
                a0_2=pi5_value_fma_lane<1>(a0_2,v2,w0);
                a0_3=pi5_value_fma_lane<1>(a0_3,v3,w0);
                a1_0=pi5_value_fma_lane<1>(a1_0,v0,w1);
                a1_1=pi5_value_fma_lane<1>(a1_1,v1,w1);
                a1_2=pi5_value_fma_lane<1>(a1_2,v2,w1);
                a1_3=pi5_value_fma_lane<1>(a1_3,v3,w1);
                a2_0=pi5_value_fma_lane<1>(a2_0,v0,w2);
                a2_1=pi5_value_fma_lane<1>(a2_1,v1,w2);
                a2_2=pi5_value_fma_lane<1>(a2_2,v2,w2);
                a2_3=pi5_value_fma_lane<1>(a2_3,v3,w2);
                a3_0=pi5_value_fma_lane<1>(a3_0,v0,w3);
                a3_1=pi5_value_fma_lane<1>(a3_1,v1,w3);
                a3_2=pi5_value_fma_lane<1>(a3_2,v2,w3);
                a3_3=pi5_value_fma_lane<1>(a3_3,v3,w3);
            }
            {
                F16::Data v0,v1;vh.load(l+2,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+2,i+2,v2,v3);
                a0_0=pi5_value_fma_lane<2>(a0_0,v0,w0);
                a0_1=pi5_value_fma_lane<2>(a0_1,v1,w0);
                a0_2=pi5_value_fma_lane<2>(a0_2,v2,w0);
                a0_3=pi5_value_fma_lane<2>(a0_3,v3,w0);
                a1_0=pi5_value_fma_lane<2>(a1_0,v0,w1);
                a1_1=pi5_value_fma_lane<2>(a1_1,v1,w1);
                a1_2=pi5_value_fma_lane<2>(a1_2,v2,w1);
                a1_3=pi5_value_fma_lane<2>(a1_3,v3,w1);
                a2_0=pi5_value_fma_lane<2>(a2_0,v0,w2);
                a2_1=pi5_value_fma_lane<2>(a2_1,v1,w2);
                a2_2=pi5_value_fma_lane<2>(a2_2,v2,w2);
                a2_3=pi5_value_fma_lane<2>(a2_3,v3,w2);
                a3_0=pi5_value_fma_lane<2>(a3_0,v0,w3);
                a3_1=pi5_value_fma_lane<2>(a3_1,v1,w3);
                a3_2=pi5_value_fma_lane<2>(a3_2,v2,w3);
                a3_3=pi5_value_fma_lane<2>(a3_3,v3,w3);
            }
            {
                F16::Data v0,v1;vh.load(l+3,i+0,v0,v1);
                F16::Data v2,v3;vh.load(l+3,i+2,v2,v3);
                a0_0=pi5_value_fma_lane<3>(a0_0,v0,w0);
                a0_1=pi5_value_fma_lane<3>(a0_1,v1,w0);
                a0_2=pi5_value_fma_lane<3>(a0_2,v2,w0);
                a0_3=pi5_value_fma_lane<3>(a0_3,v3,w0);
                a1_0=pi5_value_fma_lane<3>(a1_0,v0,w1);
                a1_1=pi5_value_fma_lane<3>(a1_1,v1,w1);
                a1_2=pi5_value_fma_lane<3>(a1_2,v2,w1);
                a1_3=pi5_value_fma_lane<3>(a1_3,v3,w1);
                a2_0=pi5_value_fma_lane<3>(a2_0,v0,w2);
                a2_1=pi5_value_fma_lane<3>(a2_1,v1,w2);
                a2_2=pi5_value_fma_lane<3>(a2_2,v2,w2);
                a2_3=pi5_value_fma_lane<3>(a2_3,v3,w2);
                a3_0=pi5_value_fma_lane<3>(a3_0,v0,w3);
                a3_1=pi5_value_fma_lane<3>(a3_1,v1,w3);
                a3_2=pi5_value_fma_lane<3>(a3_2,v2,w3);
                a3_3=pi5_value_fma_lane<3>(a3_3,v3,w3);
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
#endif
