// Copyright (C) 2026 PhilAnderson1
// MIT license
// SPDX-License-Identifier: MIT

// Included after the D128 value specializations. The caller checks the model
// shape, mask, thread count and complete query/key tile boundaries.
#ifdef __aarch64__
void iqk_pi5_prefill_128(int nq, int nk, int stride_q, int stride_k, int stride_v, int stride_m,
        long head_q, long head_k, long head_v, long head_out,
        const void * q, const void * k, const void * v, const void * mask,
        float scale, float * out, int ith) {
    constexpr int D = 128, Q = 64, K = 128, G = 4;
    struct alignas(64) Group {
        FlashMS<Q, K, true> ms;
        FlashQKV<D, Q, K> values;
        alignas(64) float16_t query[Q*D];
        int head = 0, row = 0;
        Group(float scale) : ms(scale, 0) {}
    } groups[G] = {Group(scale), Group(scale), Group(scale), Group(scale)};
    // Scores are consumed before advancing to another group. M/S and value
    // accumulators persist per group; their arithmetic order is unchanged.
    alignas(64) float scores[Q*K];
    const int kv_head = ith/2;
    const int first_head = kv_head*8 + (ith%2)*G;
    for (int row = 0; row < nq; row += Q) {
        for (int g = 0; g < G; ++g) {
            auto & group = groups[g];
            group.head = first_head + g;
            group.row = row;
            group.ms.cache = scores;
            group.ms.init_qstep();
            const auto * qr = (const float *)((const char *)q + group.head*head_q + row*stride_q);
            FlashQKfp32<D, Q, K>::convert(Q, stride_q/sizeof(float), qr, group.query);
        }
        HelperF16 kh((const char *)k + kv_head*head_k, stride_k);
        HelperF16 vh((const char *)v + kv_head*head_v, stride_v);
        for (int key = 0; key < nk; key += K) {
            for (auto & group : groups) {
                FlashQKfp32<D, Q, K>::multiply_mask_kq(kh, D, stride_m, group.query,
                        (const char *)mask + group.row*stride_m + key*sizeof(ggml_fp16_t), group.ms);
                pi5_accumulate_values_128<Q, K>(group.values.qkv_cache, vh, group.ms);
            }
            kh.next_block(K);
            vh.next_block(K);
        }
        for (auto & group : groups) {
            group.values.normalize_and_store(group.ms, 16*head_out/sizeof(float),
                    (float *)((char *)out + (group.row*16 + group.head)*head_out), nullptr, 0, nullptr, nullptr);
        }
    }
}
#endif
