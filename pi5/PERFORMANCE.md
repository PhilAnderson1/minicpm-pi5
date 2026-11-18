# Measurements and limitations

The current README tables were measured on 2026-11-17 with **0.1.3~rc2** on a
4 GB Raspberry Pi 5, MiniCPM5-2B-Q4_K_M, FP16 KV and runtime repacking. They compare
the preserved ik_llama.cpp baseline (2a0832d7 plus the zero-activation metadata
fix, shared libraries) with the mostly static 0.1.3~rc2 engine. Build/linkage
differences are included. These are single-machine synthetic-context measurements.

## Decode

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 7.69 tokens/s | 7.68 tokens/s | -0.2% |
| 8K | 4.96 tokens/s | 5.79 tokens/s | 16.7% |
| 15K | 3.70 tokens/s | 4.78 tokens/s | 29.3% |
| 23K | 2.88 tokens/s | 3.95 tokens/s | 37.1% |

Each sample generates 64 fixed-input tokens after a deterministic synthetic KV
prefix. Three pairs alternate execution order; rates are total tokens divided
by total timed decode duration. Older headline samples used 16 tokens, so rate
changes since those tables should not be attributed solely to new optimizations.

## Prefill

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 42.31 tokens/s | 48.46 tokens/s | 14.5% |
| 8K | 18.98 tokens/s | 28.38 tokens/s | 49.5% |
| 15K | 12.18 tokens/s | 20.05 tokens/s | 64.6% |
| 23K | 8.69 tokens/s | 15.08 tokens/s | 73.5% |

Each sample processes 128 new tokens after the retained prefix, with 24K context
capacity, microbatch 512 and four prefill threads. Rates use median elapsed time
from three alternating pairs. This is not whole-prompt throughput from empty.

All timed samples had zero major faults and monitoring recorded zero process
swap. Decode logits match exactly across builds and repetitions. Prefill logits
repeat exactly within each build; cross-build equality is intentionally changed
by the FP32 final normalization fix introduced in 0.1.2.

[Raw timings, hashes, settings and reproduction](results/v013-rc2-throughput/README.md).
The previous [0.1.2 tables](results/rc4-throughput/README.md) remain archived.
Earlier [prefill](results/prefill-registers-total/README.md) and
[23K decode](results/decode-23k/README.md) measurements remain archived.
The historical incremental and serving measurements below used earlier builds;
their percentages must not be added to the current direct-comparison gains.

## Release-to-release decode check

A separate matched v0.1.1 versus rc4 comparison found 1.7–2.6% gains in the
64-token samples. Short 1K results were variable; a focused recheck did not
reproduce the initial 5.5% slowdown, though a small penalty is not ruled out.
This does not establish why older historical headline rates differ.
[Full results and follow-up](results/decode-release-ab/README.md). A subsequent
[historical-build check](results/historical-decode/README.md) found that even the
unchanged original benchmark and libraries no longer reproduce the older rates.
Matched 64-token tests put v0.1.2 level at 1K and faster at 8K–23K than that original
engine; the exact historical environmental cause remains unresolved.

## Earlier v0.1.2 16K cost profile

A controlled v0.1.2 profile attributes about 68% of prefill time to attention
and 30% to projections; decode is about 41% attention and 56% projections.
Q4 projections account for 25–26% of total prefill, Q6 about 5%. Other graph
operations are a small fraction. These shares include waits, not just arithmetic.
[Profile, controls and potential-gain estimates](results/profile-v012-16k/README.md). The follow-up
[phase/counter audit](results/attention-phases-v012/README.md) attributes about
42%/15%/43% of the three measured attention phases to Q×K, mask/softmax and values.
It identifies no clear DRAM-bandwidth bottleneck; value-kernel load/FMA scheduling
was subsequently tested and integrated as lane-FMA instructions; see the
[incremental measurements](results/value-scheduling/README.md).

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


## Lane-FMA value instruction integration

A private prototype keeps the current register tile and arithmetic order but
forces lane FMAs, eliminating 12 compiler-generated broadcasts per inner-loop
iteration. At a synthetic 16K prefix, full-model incremental prefill improved
from 17.56 to 18.20 tokens/s for 128 new tokens (+3.6%), and from 17.41 to 17.97
for 512 (+3.2%), across three alternating pairs. Logits, newly written FP16 KV,
and four decode continuation steps matched exactly; no process swap or timed
major faults occurred. Explicit load-ahead scheduling did not help.

The source change is integrated and a private serving candidate passed local
model/cache/cancellation checks. The 4K HTTP replay/cancellation test also passed. Package 0.1.3~rc1 contains
the validated server; it is not part of v0.1.2
or the headline README tables. [Measurements and controls](results/value-scheduling/README.md).


Q×K query load-ahead and key-major schedules were also screened against the
0.1.3~rc1 candidate at a 16K prefix. Complete-attention throughput changes were
-0.48%/+0.28% and -1.63%/+0.07% for 128/512 new queries respectively, with exact
outputs. Neither was adopted. [Evidence](results/qk-scheduling/README.md).

A fixed-layout Q×K helper reduced complete-attention instruction counts by about
8%, but a focused six-pair follow-up measured only +0.80%/+0.70% attention
throughput at 128/512 new queries, with mixed individual pairs. No full-model
claim or production integration. [Evidence](results/qk-layout/README.md).


## Softmax/value fusion integration

Producing the value kernel's FP16 weights directly inside softmax eliminates
intermediate FP32 weight stores and repeated conversions. FP32 denominator
summation and all value arithmetic/rounding remain unchanged. A 16 KiB per-worker
weight buffer is added; the Q×K score buffer remains. Three alternating full-model
pairs at a synthetic 16K prefix measured 18.34→19.36 tokens/s (+5.56%) for 128
new tokens and 17.96→18.93 (+5.44%) for 512. All logits, new KV and four decode
continuations matched exactly; no swap or timed major faults occurred.

Source integration, local serving/model checks and the 4K HTTP replay/cancellation
test passed. Package 0.1.3~rc2 contains the validated build.
[Method and results](results/softmax-value-fusion/README.md).


## Refreshed fused-engine 16K cost profile

The 0.1.3~rc2 refresh attributes 64.8–65.5% of prefill to attention and
32.7–33.9% to projections. Decode remains about 41.3% attention and 55.7%
projections. All profiled final logits matched the release; trace overhead was
within approximately ±1.2%. Process swap remained zero, but one untraced private
sample faulted and system-wide paging occurred in some intervals. These are broad
cost shares, not small-gain measurements. [Controls and results](results/profile-fused-16k/README.md).

A subsequent key-packing prototype, amortized across four query heads, measured
-0.33%/-1.08% complete-attention throughput at 128/512 queries. All outputs were
exact; no full-model testing or integration was justified.
[Packed-key experiment](results/packed-keys-fused/README.md).


A fused-engine cache-blocking sweep covered 1/2/4/8 query groups and
128/256/512-key spans while preserving 128-key arithmetic. The existing
four-group/128-key arrangement remained best at 128 and 512 new queries.
All 196 attention comparisons, including partial-group/tail cases, were exact.
No changed blocking cleared the screen for full-model testing; production is
unchanged. [Results](results/cache-blocks-fused/README.md).
