// Copyright (C) 2026 PhilAnderson1
// SPDX-License-Identifier: MIT
// Fused weights must preserve FP32 softmax state and FP16 value outputs.
#ifndef GGML_IQK_FLASH_ATTENTION
#define GGML_IQK_FLASH_ATTENTION
#endif
#include "iqk/iqk_config.h"
#define IQK_FA_NORMALIZE_F32
#include "iqk/fa/iqk_fa_templates.h"
#include "iqk/fa/iqk_fa_128_value_registers.h"
#include "iqk/fa/iqk_fa_128_softmax.h"
#include <random>
#include <cstdio>
#include <cstring>

int main() {
    std::mt19937 rng(713);
    std::uniform_real_distribution<float> random(-1, 1);
    alignas(64) float scores[8192], copy[8192];
    alignas(64) float16_t weights[8192], values[16384], a[8192], b[8192], mask[8192];
    float32x4_t vk[32];
    for (int test = 0; test < 60; ++test) {
        FlashMS<64, 128, true> reference(1, 0), fused(1, 0);
        reference.cache = scores;
        fused.cache = copy;
        for (int j = 0; j < 64; ++j) {
            reference.M[j] = fused.M[j] = test%3 == 0 ? -INFINITY : float(j%3);
            reference.S[j] = fused.S[j] = test%3 == 0 ? 0 : 3;
        }
        for (int i = 0; i < 8192; ++i) {
            scores[i] = copy[i] = random(rng)*(test%3 == 0 ? .3f : test%3 == 1 ? 80.f : 200.f);
            a[i] = b[i] = random(rng);
            mask[i] = ((test%4 == 1 && i%128 > 60) || test%4 == 2) ? -INFINITY : 0;
        }
        for (auto & value : values) value = random(rng);
        HelperF16 vh((const char *)values, 256);
        for (int j = 0; j < 64; ++j) {
            pi5_update_softmax_128(reference, j, vk, (const char *)(mask + j*128));
            pi5_update_softmax_weights_128(fused, j, vk, (const char *)(mask + j*128), weights + j*128);
        }
        pi5_accumulate_values_registers_128(a, vh, reference);
        pi5_accumulate_values_registers_128<true>(b, vh, fused, weights);
        if (memcmp(a, b, sizeof(a)) || memcmp(reference.M, fused.M, sizeof(reference.M)) ||
                memcmp(reference.S, fused.S, sizeof(reference.S))) {
            fprintf(stderr, "FAIL fused weights test %d\n", test);
            return 1;
        }
    }
    puts("PASS 60 exact fused softmax/value checks");
}
