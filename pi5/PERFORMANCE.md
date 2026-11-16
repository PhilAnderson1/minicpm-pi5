# Measurements and limitations

Measurements were made on a 4 GB Raspberry Pi 5 with Cortex-A76 cores sampled at
2.4 GHz, CPU inference, MiniCPM5-2B-Q4_K_M, runtime weight repacking, FP16 KV,
24,576-token capacity, `-t 2 -tb 4`, and OpenMP `close`/`cores`/`PASSIVE`.
Decode measurements date from 2026-11-13/14; the direct prefill comparison was
refreshed on 2026-11-16 with the 0.1.1~rc2 engine. This is a single-machine experiment,
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

The current `0.1.1~rc2` package engine was compared with the preserved upstream
baseline: commit `2a0832d7` plus the zero-activation correctness fix. The baseline
uses shared libraries and the candidate uses the clean package's static engine
libraries. This measures the two builds, including linking differences.

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| Empty | 51.36 tokens/s | 51.41 tokens/s | 0.1% |
| 1K | 42.00 tokens/s | 44.90 tokens/s | 6.9% |
| 8K | 19.05 tokens/s | 25.67 tokens/s | 34.7% |
| 15K | 12.24 tokens/s | 17.75 tokens/s | 45.0% |
| 23K | 8.68 tokens/s | 13.22 tokens/s | 52.3% |

Each row measures 128 new tokens after the stated deterministic synthetic retained
context, not average speed for a whole prompt from empty. Context capacity is
24,576, microbatch capacity 512, and prefill uses four threads. Rates use median
elapsed times from three runs per build, in alternating baseline/candidate order.
Only one model process runs at a time. Loading, seeding, warmup, validation and
four continuation decode steps are excluded from prefill timing.

Final prefill logits, canonical new KV bytes and continuation decode logits
matched exactly across builds and repetitions (202,905,600 reference bytes).
All timed calls had zero major faults. One baseline process reached 24,112 KiB
of sampled logical swap during its run; the other five processes had none.
Three repeats provide a local comparison, not a precise confidence interval.

[Current raw results, build hashes and reproduction instructions](results/prefill-registers-total/README.md).
The [earlier shared-library comparison](results/prefill-total/README.md) remains
archived; its candidate predates KV reuse and register-resident value accumulation.

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
