# Measurements and limitations

The current README tables were measured on 2026-11-17 with **0.1.2~rc4** on a
4 GB Raspberry Pi 5, MiniCPM5-2B-Q4_K_M, FP16 KV and runtime repacking. They compare
the preserved ik_llama.cpp baseline (2a0832d7 plus the zero-activation metadata
fix, shared libraries) with the mostly static rc4 release engine. Build/linkage
differences are included. These are single-machine synthetic-context measurements.

## Decode

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 7.48 tokens/s | 7.51 tokens/s | 0.5% |
| 8K | 5.01 tokens/s | 5.81 tokens/s | 15.9% |
| 15K | 3.72 tokens/s | 4.77 tokens/s | 28.1% |
| 23K | 2.89 tokens/s | 3.96 tokens/s | 36.8% |

Each sample generates 64 fixed-input tokens after a deterministic synthetic KV
prefix. Three pairs alternate execution order; rates are total tokens divided
by total timed decode duration. Older headline samples used 16 tokens, so rate
changes since those tables should not be attributed solely to new optimizations.

## Prefill

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 42.88 tokens/s | 47.65 tokens/s | 11.1% |
| 8K | 18.92 tokens/s | 26.69 tokens/s | 41.1% |
| 15K | 12.22 tokens/s | 18.42 tokens/s | 50.7% |
| 23K | 8.68 tokens/s | 13.68 tokens/s | 57.5% |

Each sample processes 128 new tokens after the retained prefix, with 24K context
capacity, microbatch 512 and four prefill threads. Rates use median elapsed time
from three alternating pairs. This is not whole-prompt throughput from empty.

All timed samples had zero major faults and monitoring recorded zero process
swap. Decode logits match exactly across builds and repetitions. Prefill logits
repeat exactly within each build; cross-build equality is intentionally changed
by rc4's FP32 final normalization fix.

[Raw timings, hashes, settings and reproduction](results/rc4-throughput/README.md).
Earlier [prefill](results/prefill-registers-total/README.md) and
[23K decode](results/decode-23k/README.md) measurements remain archived.
The historical incremental and serving measurements below used earlier builds;
their percentages must not be added to the current direct-comparison gains.

## Release-to-release decode check

A separate matched v0.1.1 versus rc4 comparison found 1.7–2.6% gains in the
64-token samples. Short 1K results were variable; a focused recheck did not
reproduce the initial 5.5% slowdown, though a small penalty is not ruled out.
This does not establish why older historical headline rates differ.
[Full results and follow-up](results/decode-release-ab/README.md).

## Incremental prefill kernel experiments

Three alternating repetitions; medians of elapsed prefill time:

| Change | Retained prefix / batch | Before t/s | After t/s | Gain |
|---|---|---:|---:|---:|
| Q×K named accumulators | 8,192 / 128 | 20.08 | 23.19 | 15.45% |
| Q×K named accumulators | 23,552 / 128 | 9.17 | 11.28 | 23.07% |
| Q×K named accumulators | 23,552 / 512 | 9.11 | 11.16 | 22.46% |
| Wider value tile, after Q×K | 8,192 / 128 | 23.29 | 23.74 | 1.93% |
| Wider value tile, after Q×K | 23,552 / 128 | 11.31 | 11.70 | 3.43% |
| Wider value tile, after Q×K | 23,552 / 512 | 11.11 | 11.32 | 1.93% |

Raw paired CSVs are under `results/qk-registers/` and `results/value-prefill/`.
In those files variant 0 is the existing path and variant 1 is the private
candidate. Some initial baseline samples have major faults; candidate samples
in those studies have none. Do not sum the percentages or call them a single
end-to-end comparison. Each experiment compared 7,833,600 candidate logits and
165,150,720 new KV bytes exactly, including four following decode steps. This
checks every new KV byte and final-token prefill logits, not all prefill logits.

Earlier value-kernel validation measured about 23.47 t/s at 8K/128 and 11.31 t/s at
23,552/512 after value integration. Separate-run measurements have variation;
the controlled paired experiments are the evidence for the stated gains.

The included `prefill_check` reproduces the deterministic synthetic-prefix
workload and reports the current build's incremental speed. It checks repeat
logit consistency, not an independent historical reference. To compare engine
revisions, build separate worktrees from ENGINE_REVISIONS.txt and point the
portable test builder at each build with MINICPM_PI5_BUILD_DIR. Never run them
concurrently. The archived private kernels/build scripts are not bundled; the
engine commits preserve the final adopted changes, while CSVs preserve the
original experiment evidence.

## Actual serving

After Q×K integration, a real 24,500-token prompt took 1,269.8 seconds overall,
with prompt evaluation averaging 19.32 t/s. Saved-cache restore plus eight
generated tokens took about 3.01 seconds and reevaluated one prompt token.
This was not an identical paired comparison against the original server.

After the earlier wider-value-tile integration, the HTTP smoke passed again: short saved-cache replay
and stream-disconnect recovery matched the equivalent live replay. The 25-minute
real-prompt HTTP test was not repeated for that final kernel-only change; engine
24K cache/cancellation checks were repeated. Sanitized timing summaries are in
`results/qk-integration-http.json` and `results/value-integration-http.json`.

The register-resident value serving candidate subsequently passed the full
24,500-token HTTP test: 1,148.79 seconds overall, 21.36 prompt tokens/s, and
2.80 seconds to restore the long prompt and generate eight tokens. This was
not a controlled A/B comparison. The clean 0.1.1~rc2 package also passed HTTP
smoke checks. [Validation details](results/value-registers/README.md).

Capacity tests reached about 3.4 GiB process resident high-water memory and
substantial paging. The host used zram with a microSD-backed writeback device;
logical swapped bytes must not be counted as additional physical RAM. No claim
of large RAM savings or context-independent generation speed is made.

## Investigations not adopted

- Smaller prefill query tiles: full-model regressions of about 6% and 3%.
- Additional decode attention specialization/prefetch variants: no useful gain.
- Combined mask/scale/max pass: about +0.65% near24K, insufficient benefit.
- Dynamic queue of existing 64-query chunks: +0.04% for 128-token and -0.47%
  for 512-token near24K batches; retain static scheduling.
- Microbatch 128: modest memory savings, no compelling general speed advantage.

Before the register-resident value change, the long-context attention profile was roughly 36% Q×K, 15% mask/softmax
and 49% values. These are summed overlapping worker times, not full-model
wall-clock percentages. Per-worker traces showed 4–5% average arrival slack near
24K, but dynamic scheduling did not turn it into a speedup. Waiting time is not
a promise of recoverable performance. Relevant compact CSVs are retained in
`results/softmax-audit/` and `results/worker-balance/`.
