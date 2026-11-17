// Copyright (C) 2026 PhilAnderson1
// SPDX-License-Identifier: MIT
#pragma once
#include "ggml.h"
// Four query heads sharing F16 K/V, D128, a shared mask, and nk divisible
// by 128. Returns unnormalised values plus M/S for the existing Pi reducer.
#if defined(__aarch64__)
void iqk_pi5_decode_128(int nk, int stride_q, int stride_k, int stride_v,
        const float * q, const char * k, const char * v,
        const ggml_fp16_t * mask, float scale, float * out, float * M, float * S);
#endif
