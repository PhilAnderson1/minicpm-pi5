// AArch64 D128 value accumulation: reuse each softmax weight across 32 values.
// Included only by iqk_fa_128_128.cpp after iqk_fa_templates.h.
// FP16 scaling and per-output FMA order match the generic 16-value kernel.
#ifdef __aarch64__
namespace {
template <int q_step, int k_step>
inline void pi5_accumulate_values_128(float16_t * qkv_cache,
        const HelperF16& vh, const FlashMS<q_step, k_step>& fms) {
    constexpr int D = 128;
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
        for (int i = 0; i < D/F16::block_size; i += 4) {
            for (int l = 0; l < k_step; l += 4) {
                F16::Data v00, v01, v02, v03;
                vh.load(l+0, i+0, v00, v01);
                vh.load(l+0, i+2, v02, v03);
                F16::Data v10, v11, v12, v13;
                vh.load(l+1, i+0, v10, v11);
                vh.load(l+1, i+2, v12, v13);
                F16::Data v20, v21, v22, v23;
                vh.load(l+2, i+0, v20, v21);
                vh.load(l+2, i+2, v22, v23);
                F16::Data v30, v31, v32, v33;
                vh.load(l+3, i+0, v30, v31);
                vh.load(l+3, i+2, v32, v33);
                for (int j = 0; j < q_step; ++j) {
                    auto R = qkv_cache + D*j;
                    auto s0 = F16::load(R + F16::block_size*(i+0));
                    auto s1 = F16::load(R + F16::block_size*(i+1));
                    auto s2 = F16::load(R + F16::block_size*(i+2));
                    auto s3 = F16::load(R + F16::block_size*(i+3));
                    auto vs = F16::set4(fms.cache + k_step*j + l);
                    s0 = F16::fmadd_lane0(s0, v00, vs);
                    s1 = F16::fmadd_lane0(s1, v01, vs);
                    s2 = F16::fmadd_lane0(s2, v02, vs);
                    s3 = F16::fmadd_lane0(s3, v03, vs);
                    s0 = F16::fmadd_lane1(s0, v10, vs);
                    s1 = F16::fmadd_lane1(s1, v11, vs);
                    s2 = F16::fmadd_lane1(s2, v12, vs);
                    s3 = F16::fmadd_lane1(s3, v13, vs);
                    s0 = F16::fmadd_lane2(s0, v20, vs);
                    s1 = F16::fmadd_lane2(s1, v21, vs);
                    s2 = F16::fmadd_lane2(s2, v22, vs);
                    s3 = F16::fmadd_lane2(s3, v23, vs);
                    s0 = F16::fmadd_lane3(s0, v30, vs);
                    s1 = F16::fmadd_lane3(s1, v31, vs);
                    s2 = F16::fmadd_lane3(s2, v32, vs);
                    s3 = F16::fmadd_lane3(s3, v33, vs);
                    F16::store(R + F16::block_size*(i+0), s0);
                    F16::store(R + F16::block_size*(i+1), s1);
                    F16::store(R + F16::block_size*(i+2), s2);
                    F16::store(R + F16::block_size*(i+3), s3);
                }
            }
        }
}

// Specialize only complete prefill groups; partial groups and decode stay generic.
#define PI5_VALUE_GROUP(Q, K) \
    template <> template <> \
    inline void FlashQKV<128, Q, K>::accumulate_qkv<HelperF16, FlashMS<Q, K>>( \
            const HelperF16& vh, const FlashMS<Q, K>& fms) { \
        pi5_accumulate_values_128<Q, K>(qkv_cache, vh, fms); \
    }
PI5_VALUE_GROUP(8, 32)
PI5_VALUE_GROUP(8, 64)
PI5_VALUE_GROUP(8, 128)
PI5_VALUE_GROUP(12, 32)
PI5_VALUE_GROUP(12, 64)
PI5_VALUE_GROUP(12, 128)
PI5_VALUE_GROUP(16, 32)
PI5_VALUE_GROUP(16, 64)
PI5_VALUE_GROUP(16, 128)
PI5_VALUE_GROUP(32, 32)
PI5_VALUE_GROUP(32, 64)
PI5_VALUE_GROUP(32, 128)
PI5_VALUE_GROUP(64, 32)
PI5_VALUE_GROUP(64, 64)
PI5_VALUE_GROUP(64, 128)
#undef PI5_VALUE_GROUP
} // namespace
#endif
