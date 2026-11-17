// Compare the Pi decode specialization with unchanged generic attention.
#include "ggml.h"
#include "iqk/iqk_flash_impl.h"
#include "iqk/fa/iqk_fa_128_decode.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <vector>
static void check(bool ok, const char * message) {
    if (!ok) { fprintf(stderr, "FAIL %s\n", message); exit(1); }
}
int main() {
    ggml_time_init();
    std::mt19937 rng(73);
    int cases = 0;
    for (int nk : {128, 256, 512, 16640}) {
        for (int padding : {0, 16}) {
            const int sq = 128 + padding, sk = 128 + padding;
            for (float amplitude : {0.f, .3f, 2.f}) {
                std::uniform_real_distribution<float> random(-amplitude, amplitude);
                std::vector<float> q(4*sq);
                std::vector<ggml_fp16_t> k(nk*sk), v(k.size()), mask(nk);
                for (auto & x : q) x = random(rng);
                for (auto & x : k) x = ggml_fp32_to_fp16(random(rng));
                for (auto & x : v) x = ggml_fp32_to_fp16(random(rng));
                for (int pattern = 0; pattern < 4; ++pattern) {
                    for (int t = 0; t < nk; ++t) {
                        bool hidden = pattern == 3 || (pattern == 1 && t >= nk - 73) ||
                            (pattern == 2 && t%11 == 0);
                        mask[t] = ggml_fp32_to_fp16(hidden ? -INFINITY : 0.f);
                    }
                    float ref[512], out[512], rm[4], rs[4], m[4], s[4];
                    const float scale = 1.f/sqrtf(128);
                    check(iqk_flash_attn_impl(GGML_TYPE_F16, GGML_TYPE_F16, 128, 128,
                        4, nk, sq*4, sk*2, sk*2, 0, 128, q.data(), k.data(), v.data(),
                        mask.data(), nullptr, 0, scale, 0, ref, rm, rs), "generic attention");
                    iqk_pi5_decode_128(nk, sq*4, sk*2, sk*2, q.data(),
                        (const char *)k.data(), (const char *)v.data(), mask.data(), scale, out, m, s);
                    check(!memcmp(ref, out, sizeof(ref)), "exact unnormalised values");
                    check(!memcmp(rm, m, sizeof(m)), "exact maxima");
                    check(!memcmp(rs, s, sizeof(s)), "exact sums");
                    ++cases;
                }
            }
        }
    }
    printf("PASS %d exact decode cases, including strided inputs and masked rows\n", cases);
}
