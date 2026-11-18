# Fused-attention cache-blocking sweep

2026-11-18, Raspberry Pi 5 / Cortex-A76 / 4 GB. Reference: the validated
0.1.3~rc2 fused serving archive. Private experiment only; no source, package or
installed-service change.

## Question and method

The fused path changed weight traffic and added 16 KiB of shared FP16 weight
scratch per worker. Recheck whether the previous four-group/128-key traversal
still wins. Query tiles remain 64 rows; only group count and traversal change.

Each worker owns four query heads sharing one KV head. Groups represent one
64-query tile of one head. The eight-group case spans two query tiles across
those same four heads; it does not leave workers idle or change head ownership.
Test 1/2/4/8 groups and 128/256/512-key spans. A larger span still advances each
query's softmax and value accumulation through identical 128-key arithmetic
steps. Final rounding, reduction order and FP16 KV are unchanged.

Complete attention at a synthetic causal 16K prefix, 128/512 new queries, four
workers, OMP close/core placement and passive waiting. Six rotated samples per
variant (two PMU groups × three repetitions), warmup before each timed call.
Latency is median slowest-worker time. Includes a linked production reference,
an exact private driver clone, and all 12 configurations. The private 4/128 case
uses the same blocking as production but a general sweep driver; small timing
differences do not constitute a new cache-blocking optimization.

## Results

| Configuration | 128-token ms | Throughput change | 512-token ms | Throughput change |
| --- | ---: | ---: | ---: | ---: |
| production | 100.960 | +0.00% | 414.148 | +0.00% |
| clone | 100.631 | +0.33% | 419.968 | -1.39% |
| g1_k128 | 109.650 | -7.93% | 458.997 | -9.77% |
| g1_k256 | 112.381 | -10.16% | 452.139 | -8.40% |
| g1_k512 | 111.268 | -9.26% | 461.892 | -10.34% |
| g2_k128 | 103.314 | -2.28% | 429.200 | -3.51% |
| g2_k256 | 104.771 | -3.64% | 432.596 | -4.26% |
| g2_k512 | 105.923 | -4.69% | 442.444 | -6.40% |
| g4_k128 | 100.186 | +0.77% | 413.295 | +0.21% |
| g4_k256 | 100.790 | +0.17% | 427.616 | -3.15% |
| g4_k512 | 101.456 | -0.49% | 435.170 | -4.83% |
| g8_k128 | 101.582 | -0.61% | 422.973 | -2.09% |
| g8_k256 | 101.580 | -0.61% | 423.871 | -2.29% |
| g8_k512 | 102.913 | -1.90% | 432.948 | -4.34% |

Four groups / 128 keys remains the best measured arrangement at both shapes.
The same-layout sweep control measures +0.77%/+0.21%; the unchanged clone varies
+0.33%/-1.39%. Neither is evidence of a useful new blocking choice. All changes
to group count lose at both shapes; larger spans do not show a compelling gain.
No configuration warrants a full-model experiment against the predeclared
2–3% full-model integration threshold. Retain production.

## Correctness and scope

All 168 timed complete-attention calls match the generic production reference
bitwise. Another 28 comparisons at a 63-token prefix with 64/192 new queries
cover partial eight-group batches and key-span tails, also exact. Each worker's
PMU group ran without multiplexing. Raw outliers remain in the CSVs. This is an
attention-level screen, not a full-model throughput benchmark or an exhaustive
search over every query/key tile size.

Variant IDs are in `variants.json`. Generator, sources, build commands and
executables remain in `build-cache-fused/`. `counters.csv` records four worker
rows per call; `edges.csv` contains the additional correctness cases.
