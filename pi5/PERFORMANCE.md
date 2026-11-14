# Measurements and limitations

Measurements were made on a 4 GB Raspberry Pi 5 with Cortex-A76 cores sampled at
2.4 GHz, CPU inference, MiniCPM5-2B-Q4_K_M, runtime weight repacking, FP16 KV,
24,576-token capacity, `-t 2 -tb 4`, and OpenMP `close`/`cores`/`PASSIVE`.
Earlier experiments ran on 2026-11-13; the direct prefill comparison ran on
2026-11-14. This is a single-machine experiment,
not a multi-device study. Small differences, cold faults and memory pressure
matter; the number of repetitions is deliberately reported.

## Decode

| Retained prefix | Baseline tokens/s | Pi profile tokens/s | Reported gain |
|---:|---:|---:|---:|
| 1,024 | 7.9542 | 8.1456 | 2.41% |
| 8,192 | 5.0647 | 6.0483 | 19.42% |
| 15,360 | 3.7725 | 4.9959 | 32.43% |
| 23,552 | 2.9345 | 3.7412 | 27.49% |

The 1K–15K user-run checks used synthetic retained KV, three alternating repetitions,
16 generated tokens each, and exact-logit comparisons. The baseline is the
unoptimized research path with the zero-activation metadata fix, not the older
installed `/opt` build. `results/reported-decode.csv` transcribes the terminal
summaries; raw per-repetition data is not claimed for that file.

The 23K row was measured on 2026-11-14 against the preserved baseline and final
engine libraries used for the direct prefill comparison. Separate processes keep
only one model/context resident at a time. It retains the earlier decode settings:
512 tokens of capacity beyond the retained prefix, 64-token batch/microbatch
capacity, FP16 KV, repacking, two decode threads and four batch threads.

Each process seeds identical synthetic KV, warms one decode step, removes that
step, then times 16 decode steps. Logit capture/comparison is outside the timer.
Three pairs run in alternating order; throughput is 48 tokens divided by summed
decode time, matching the earlier decode aggregation. All 16 logit vectors match
exactly across builds and repetitions (41,779,200 bytes compared). All samples
had zero major faults and recorded 2.4 GHz. Candidate samples ranged from 3.63 to
3.80 t/s, so the aggregate should not be treated as an exact performance guarantee.

[23K raw timings, build hashes and method](results/decode-23k/README.md).

The included `decode_check` runs both profile settings in the current library.
Both now share the deployed arithmetic fixes and prefill kernels. It does not
recreate every historical binary, and it is not a long sustained-generation test.

## Direct prefill comparison

The final engine was compared directly with the same upstream baseline used in
the earlier research: commit `2a0832d7` plus the zero-activation correctness fix.
The final source matches `3ed2a774`. Both library builds use matching compiler
flags; this measures the engine changes rather than static-linking differences.

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| Empty | 50.16 tokens/s | 51.28 tokens/s | 2.2% |
| 1K | 42.23 tokens/s | 45.21 tokens/s | 7.1% |
| 8K | 18.82 tokens/s | 23.57 tokens/s | 25.3% |
| 15K | 12.11 tokens/s | 15.31 tokens/s | 26.5% |
| 23K | 8.21 tokens/s | 10.96 tokens/s | 33.5% |

Each row measures a 128-token prefill batch after the stated synthetic retained
context. It is not average throughput for a whole prompt from empty. Context
capacity is 24,576, microbatch capacity 512, and prefill uses four threads in both
builds. Speeds use median elapsed times from three runs per build; run order
alternates baseline/candidate, candidate/baseline, baseline/candidate.

Each case gets an untimed warmup. Loading, seeding, output checks and four
following decode steps are outside the timer. Prefill logits, canonical new KV
bytes and following decode logits matched exactly across both builds and all
repetitions (202,905,600 reference bytes compared).

All 1K-and-longer timed samples had zero major faults. The first empty-context
baseline sample had 24; its small apparent gain should be treated cautiously
because baseline speeds ranged from 48.54 to 51.35 t/s. Every recorded frequency
was 2.4 GHz, with temperatures between 49.6 and 65.0°C. Three repeats establish a
useful local comparison, not a precise statistical confidence interval.

[Raw results, build hashes and reproduction instructions](results/prefill-total/README.md).

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

Current-build validation measured about 23.47 t/s at 8K/128 and 11.31 t/s at
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

After value integration, the HTTP smoke passed again: short saved-cache replay
and stream-disconnect recovery matched the equivalent live replay. The 25-minute
real-prompt HTTP test was not repeated for that final kernel-only change; engine
24K cache/cancellation checks were repeated. Sanitized timing summaries are in
`results/qk-integration-http.json` and `results/value-integration-http.json`.

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

The latest long-context attention profile was roughly 36% Q×K, 15% mask/softmax
and 49% values. These are summed overlapping worker times, not full-model
wall-clock percentages. Per-worker traces showed 4–5% average arrival slack near
24K, but dynamic scheduling did not turn it into a speedup. Waiting time is not
a promise of recoverable performance. Relevant compact CSVs are retained in
`results/softmax-audit/` and `results/worker-balance/`.
