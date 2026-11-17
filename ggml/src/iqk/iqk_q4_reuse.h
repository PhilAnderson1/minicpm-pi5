// Copyright (C) 2026 PhilAnderson1
// MIT license; SPDX-License-Identifier: MIT
#pragma once
#include <cstddef>
#include "iqk_config.h"
#if defined(IQK_IMPLEMENT) && defined(__aarch64__)
struct DataInfo;
// Caller checks the Q4_K_R4 / Q8_K32 types and supplies a contiguous 8..128-token tile.
void iqk_q4_reuse(int n, const void * vx, size_t bx, const DataInfo& info, int nrc_x, int batch);
#endif
