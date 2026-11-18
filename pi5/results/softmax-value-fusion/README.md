# Softmax-to-value weight production fusion

Private experiment against validated 0.1.3~rc1 on Cortex-A76 / Raspberry Pi 5,
2026-11-17. The experiment initially made no production changes. The source is now
integrated into a private serving candidate; installed service is unchanged.

## Change

Softmax still computes exponentials and its denominator in FP32, using the same
polynomial, range fallback and summation order. It now converts each resulting
weight once to FP16 and writes it directly to the buffer consumed by the value
kernel. The FP32 normalized-weight stores are omitted; the value kernel loads
FP16 weights instead of repeatedly loading and converting FP32 weights for each
of its four output-dimension slices. FP16 KV, accumulator rounding, per-output
FMA order and final FP32 normalization remain unchanged.

This is producer/consumer fusion, not a buffer-free or all-register algorithm.
The 32 KiB FP32 Q×K score buffer remains necessary and is still read by softmax.
The full-block candidate adds a 16 KiB per-worker FP16 weight buffer; the four-row
candidate uses 1 KiB and interleaves softmax/value work in four-row groups. The
existing all-masked update_M behavior is retained. Both fast and fallback exp
paths write half weights directly, rather than doing a separate conversion pass.

Earlier experiments converted weights after the original FP32 stores and then
reloaded them. This experiment removes those stores and the extra conversion
pass, rather than only adding a conversion cache.

## Complete attention

Synthetic causal 16K prefix, four workers, 128/512 new queries, six rotated
samples per variant (two PMU groups × three repetitions), OMP close/core
placement and passive waiting. Median slowest-worker latency per call:

| Variant | 128 queries ms | Throughput gain | 512 queries ms | Throughput gain |
| --- | ---: | ---: | ---: | ---: |
| Production | 110.13 | — | 455.51 | — |
| Unchanged private clone | 110.88 | -0.68% | 460.45 | -1.07% |
| Full-block fusion | 102.16 | +7.80% | 420.64 | +8.29% |
| Four-row fusion | 102.62 | +7.32% | 421.78 | +8.00% |

60 direct fused-state/value checks cover ordinary and wide-range scores, masked
and fully masked rows, initial and existing maxima/denominators. All FP16 value
outputs, maxima and FP32 denominators match bitwise. Every complete-attention
output matches the generic production reference bitwise. The small difference
between the fused variants is not claimed as a definitive ranking; the
full-block version was selected for the full-model check.

## Full-model validation method

Three alternating production/fused pairs at each batch size, synthetic 16K KV
prefix, 24K capacity, FP16 KV, ub512, t2/tb4. Model is resident/repacked with mmap
disabled. Prefill dispatch coverage must equal 42 layers × 4 workers. Outputs
are compared against retained independent production references: all final
prefill logits, all newly written KV bytes, and four subsequent decode steps.
Production references are bit-identical across the recent precision-preserving
changes. Decode steps check correctness, not decode throughput.

Raw samples, private source generators/build scripts and memory logs are in
`build-softmax-value-fusion/`. Variant IDs: 1 production, 2 private clone,
3 full-block fusion, 4 four-row fusion. In model CSVs, 1 is production and 2
is full-block fusion. No cold full-prompt speedup is inferred from incremental
prefill or attention-only measurements.


## Full-model results

| New tokens at 16K | Production tokens/s | Fused tokens/s | Throughput gain |
| --- | ---: | ---: | ---: |
| 128 | 18.34 | 19.36 | +5.56% |
| 512 | 17.96 | 18.93 | +5.44% |

Medians of three samples per mode. All paired gains were positive: +4.44–6.99%
for 128 new tokens and +5.25–5.55% for 512. Every prefill logit, new KV byte and
four-step decode continuation matched the production reference exactly. No
sampled process swap or timed major faults; post-run CPU frequency stayed at
2.4 GHz and maximum recorded temperature was 68.3 C.

This exceeds the predeclared 2–3% full-model threshold. Recommend integrating
the full-block producer/consumer path into a private serving build and running
HTTP replay/cancellation checks. No production source, service, package, public
release or headline README benchmark table has been changed by this experiment.


## Serving integration

Source now shares a templated softmax implementation and value kernel between
the FP32 reference and fused FP16-weight input. `pi5/tests/fused_weights_check.cpp`
is included in the normal Pi test build. All 60 direct cases passed, as did the
integrated 16K-prefix model checks at 128/512 new tokens and the short engine
state/cache/cancellation suite. Candidate timing agrees with the prototype;
these two validation runs are not a new benchmark claim.

The user-run 4K HTTP test passed cold/live parity, cache restore and stream
cancellation. Package 0.1.3~rc2 contains the same tested executable after
stripping. The installed service has not been changed by packaging. Artifact
hashes and compact model timings are in `serving-validation.json` and
`serving-model-*.csv`.
