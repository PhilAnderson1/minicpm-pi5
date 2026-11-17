// Copyright (C) 2026 PhilAnderson1
// MIT license
// SPDX-License-Identifier: MIT
#pragma once

// Included after iqk_fa_templates.h. Used only by the guarded Pi D128
// prefill path; generic attention and single-token decode stay unchanged.
#ifdef __aarch64__
// Ordinary branch of v_expf in iqk_utils.h, with identical operations.
// That helper credits Justine Tunney and Arm's optimized routine.
// Keep constants and arithmetic synchronized with that helper.
static inline float32x4_t pi5_exp_common(float32x4_t x) {
    const float32x4_t r = vdupq_n_f32(0x1.8p23f);
    const float32x4_t z = vfmaq_f32(r, x, vdupq_n_f32(0x1.715476p+0f));
    const float32x4_t n = vsubq_f32(z, r);
    const float32x4_t b = vfmsq_f32(vfmsq_f32(x, n, vdupq_n_f32(0x1.62e4p-1f)), n,
                                    vdupq_n_f32(0x1.7f7d1cp-20f));
    const uint32x4_t e = vshlq_n_u32(vreinterpretq_u32_f32(z), 23);
    const float32x4_t k = vreinterpretq_f32_u32(vaddq_u32(e, vreinterpretq_u32_f32(vdupq_n_f32(1))));
    const float32x4_t u = vmulq_f32(b, b);
    const float32x4_t j = vfmaq_f32(
        vmulq_f32(vdupq_n_f32(0x1.ffffecp-1f), b),
        vfmaq_f32(vfmaq_f32(vdupq_n_f32(0x1.fffdb6p-2f), vdupq_n_f32(0x1.555e66p-3f), b),
                  vfmaq_f32(vdupq_n_f32(0x1.573e2ep-5f), vdupq_n_f32(0x1.0e4020p-7f), b), u), u);
    return vfmaq_f32(k, j, k);
}

static inline float pi5_load_scores_with_min(FlashMS<64, 128, true> & ms, int j, float32x4_t * vk, const char * mask, float & minimum) {
    auto vzero = vdupq_n_f16(0);
    auto vinf  = vdupq_n_f32(-INFINITY);
    for (int l = 0; l < 128/8; ++l) {
        auto vm = vceqq_f16(vzero, vld1q_f16((const float16_t *)mask + 8*l));
        auto vm1 = vzip1q_u16(vm, vm);
        auto vm2 = vzip2q_u16(vm, vm);
        auto kq  = vld1q_f32_x2(ms.cache + 128*j + 8*l);
        vk[2*l+0] = vreinterpretq_f32_u32(vorrq_u32(vandq_u32(vreinterpretq_u32_f32(kq.val[0]), vm1),
                                                    vbicq_u32(vreinterpretq_u32_f32(vinf), vm1)));
        vk[2*l+1] = vreinterpretq_f32_u32(vorrq_u32(vandq_u32(vreinterpretq_u32_f32(kq.val[1]), vm2),
                                                    vbicq_u32(vreinterpretq_u32_f32(vinf), vm2)));
    }
    float32x4_t vmax = vdupq_n_f32(-INFINITY);
    float32x4_t vmin = vdupq_n_f32(INFINITY);
    auto vscale32 = vcvt_f32_f16(vget_low_f16(ms.vscale));
    if (ms.softcap <= 0.0f) {
        for (int l = 0; l < 128/4; ++l) {
            vk[l] = vmulq_f32(vscale32, vk[l]);
            vmax = vmaxq_f32(vmax, vk[l]);
            vmin = vminq_f32(vmin, vk[l]);
        }
    } else {
        auto v_softcap = vdupq_n_f32(ms.softcap);
        for (int l = 0; l < 128/4; ++l) {
            vk[l] = vmulq_f32(vscale32, vk[l]);
            vk[l] = vmulq_f32(v_softcap, v_tanh(vk[l]));
            vmax = vmaxq_f32(vmax, vk[l]);
            vmin = vminq_f32(vmin, vk[l]);
        }
    }
    minimum = vminvq_f32(vmin);
    return vmaxvq_f32(vmax);
}
// Preserve the original polynomial and summation order. The row-wide range
// check replaces 32 individual vector range checks. -80 <= x <= 0 stays
// conservatively inside v_expf's ordinary branch (abs(n) <= 126).
static inline void pi5_update_softmax_128(FlashMS<64, 128, true> & ms, int j,
        float32x4_t * vk, const char * mask) {
    float minimum;
    const float maximum = pi5_load_scores_with_min(ms, j, vk, mask, minimum);
    ms.update_M(j, maximum);
    if (!(ms.M[j] > -INFINITY)) return;
    if (!(minimum - ms.M[j] >= -80.f && maximum <= ms.M[j])) {
        ms.update_S(j, vk);
        return;
    }
    auto m = vdupq_n_f32(ms.M[j]);
    auto sum = vdupq_n_f32(0);
    for (int l = 0; l < 32; l += 4) {
        float32x4_t values[4];
        for (int u = 0; u < 4; ++u) values[u] = pi5_exp_common(vsubq_f32(vk[l + u], m));
        for (int u = 0; u < 4; ++u) {
            vk[l + u] = values[u];
            sum = vaddq_f32(sum, values[u]);
            vst1q_f32(ms.cache + 128*j + 4*(l + u), values[u]);
        }
    }
    ms.S[j] += vaddvq_f32(sum);
}
#endif
