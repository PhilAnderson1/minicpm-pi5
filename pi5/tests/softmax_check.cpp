// Exact state comparison against the unchanged generic softmax.
#define GGML_IQK_FLASH_ATTENTION
#include "ggml.h"
#include "iqk/iqk_flash_impl.h"
#include "iqk/iqk_config.h"
#include "iqk/fa/iqk_fa_templates.h"
#include "iqk/fa/iqk_fa_128_softmax.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>

static void check(bool ok, const char * message) {
    if (!ok) { fprintf(stderr, "FAIL %s\n", message); exit(1); }
}

int main() {
    ggml_time_init();
    std::mt19937 rng(71);
    std::uniform_real_distribution<float> distribution(-1, 1);
    int cases = 0;
    for (float amplitude : {0.f, 1.f, 100.f, 1000.f}) {
        for (float cap : {0.f, 2.f}) {
            for (int mask_kind = 0; mask_kind < 4; ++mask_kind) {
                float scores[2][64*128];
                FlashMS<64, 128, true> ms[2] = {{1.f/sqrtf(128), cap}, {1.f/sqrtf(128), cap}};
                for (int t = 0; t < 2; ++t) {
                    ms[t].cache = scores[t];
                    ms[t].init_qstep();
                    for (int j = 0; j < 64; ++j) {
                        ms[t].vms[j] = 0;
                        ms[t].need_scaling[j] = 0;
                    }
                }
                // Keep running maxima/sums across blocks to test rescaling.
                for (int block = 0; block < 16; ++block) {
                    for (float & x : scores[0]) x = amplitude*distribution(rng);
                    memcpy(scores[1], scores[0], sizeof(scores[0]));
                    for (int j = 0; j < 64; ++j) {
                        ggml_fp16_t mask[128];
                        for (int k = 0; k < 128; ++k) {
                            const bool hidden = mask_kind == 3 ||
                                (mask_kind == 1 && k > j + block*4) ||
                                (mask_kind == 2 && (k + block)%11 == 0);
                            mask[k] = ggml_fp32_to_fp16(hidden ? -INFINITY : 0.f);
                        }
                        float32x4_t vk[32];
                        ms[0].update_M_S(j, vk, (const char *)mask);
                        pi5_update_softmax_128(ms[1], j, vk, (const char *)mask);
                    }
                    check(!memcmp(scores[0], scores[1], sizeof(scores[0])), "exact score probabilities");
                    check(!memcmp(ms[0].M, ms[1].M, sizeof(ms[0].M)), "exact maxima");
                    check(!memcmp(ms[0].S, ms[1].S, sizeof(ms[0].S)), "exact sums");
                    check(!memcmp(ms[0].vms, ms[1].vms, sizeof(ms[0].vms)), "exact rescale factors");
                    check(!memcmp(ms[0].need_scaling, ms[1].need_scaling, sizeof(ms[0].need_scaling)), "exact rescale flags");
                    ++cases;
                }
            }
        }
    }
    printf("PASS %d block-state comparisons, including all-masked, mixed masks, rescaling and extreme score ranges\n", cases);
}
