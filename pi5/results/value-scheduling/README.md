# D128 value instruction scheduling investigation

Private experiment against v0.1.2 on the 4 GB Raspberry Pi 5, 2026-11-17.
The experiment initially left production sources unchanged; the lane-FMA
helper is now integrated in source and a private serving candidate. Installed
binaries and release packages are unchanged.

The current 4-query × 32-output kernel already retains its accumulators in
registers and overlaps some next-key loads with FMAs. GCC nevertheless emits
12 vector broadcasts per four-key inner-loop iteration: the first key uses
lane FMAs, but the next three use broadcasts followed by vector FMAs.

The candidate expresses each FMA as a small non-volatile AArch64 inline-assembly
operation, constraining weights to the low vector registers required by lane
instructions. Each accumulator remains a read/write operand, preserving its
key order and FP16 arithmetic. Generated assembly has 64 lane FMAs, zero
broadcasts, and no hot-loop accumulator spills. The compiler still schedules
loads and independent accumulator operations. This is a compiler/code-generation
experiment, not a precision or KV-cache change.

## Controls and validation

- Complete attention: causal synthetic 16K prefix, 128/512 new queries, four
  workers, six rotated samples per variant, two PMU counter groups. Median of
  the slowest worker per call. Production, unchanged private clone, lane-FMA
  candidate, and explicit load-ahead candidate all run in the same executable.
- 120 direct bitwise value comparisons exercise zero/nonzero scores, two value
  magnitudes and all accumulator rescaling states.
- All complete-attention output floats must match the generic production
  reference exactly. FP32 final normalization matches v0.1.2.
- Full model: three alternating production/candidate pairs at each batch size,
  synthetic 16K KV prefix, 24K capacity, FP16 KV, ub512, t2/tb4, OMP close/core
  placement and passive waiting. Model is repacked and resident, mmap disabled.
- Full-model reference prefill logits additionally match the independently
  linked release executable from the phase-profile investigation. Every timed
  run checks exact logits, all newly written KV bytes and four decode steps
  against production references. Every timed prefill must hit the wrapper 168
  times (42 layers × 4 workers).
- Raw timings retain outliers. Phase timings and attention-only gains are not
  whole-model speedups. Decode timings are correctness continuations, not a
  powered decode-performance comparison.

`prepare.py`, `build.sh`, `run-model.py` retain the private prototype workflow;
`counters.csv`, `summary.json`, `model-*.csv`, `model-summary.json`, and assembly
extracts retain evidence. Run benchmarks without another model server or builds.
This incremental benchmark does not measure a cold 16K prompt from empty KV.

## Results

| New tokens at 16K prefix | Production tokens/s | Lane-FMA tokens/s | Throughput gain |
| --- | ---: | ---: | ---: |
| 128 | 17.56 | 18.20 | 3.6% |
| 512 | 17.41 | 17.97 | 3.2% |

Medians of three timed samples per mode. All three pairs favoured the candidate:
+2.4–5.0% at 128 tokens and +3.0–4.0% at 512 tokens. All logits, KV bytes and
four-token decode continuations matched exactly. No timed major page faults or
sampled process swap; reported CPU frequency stayed at 2.4 GHz and maximum
sampled post-run temperature was 69.4 C.

Complete-attention gains were +5.1%/+5.7% versus linked production at 128/512
queries. The unchanged private clone measured +0.1%/+0.9%, indicating a small
layout effect; lane FMAs still beat that control by +5.0%/+4.8%. Attention retired
about 3.9% fewer instructions. Explicit load-ahead measured -2.1%/-0.7%, so it
was rejected. These attention numbers include retained timing outliers and are
not substituted for the full-model results above.

Recommendation: carry the lane-FMA version into a serving candidate and repeat
HTTP replay/cancellation checks before production integration. The change has not been deployed, packaged, or added to the headline README
benchmark tables.

Compact evidence is copied to `pi5/results/value-scheduling/`; the executable
prototypes, generation/build scripts and full memory samples remain in
`build-value-scheduling/`.


## Serving candidate

The source helper and private serving build passed exact 16K model checks at
128/512 new tokens, including KV bytes and four decode continuations, plus
short engine cache/cancellation tests. Generated assembly retains 64 lane FMAs,
zero broadcasts and no hot-loop accumulator spills. The 4K HTTP cold/live replay, saved-cache restore and cancellation tests
passed. Package 0.1.3~rc1 contains the same tested server (after stripping);
the installed service is unchanged. See `serving-validation.json` and
`serving-model-*.csv`. Local runner: `build-value-lane-serving/test-http.sh`.
