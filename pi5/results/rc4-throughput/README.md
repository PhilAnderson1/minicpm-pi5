# rc4 decode and prefill comparison

Measured on 2026-11-17 on a 4 GB Raspberry Pi 5, using MiniCPM5-2B-Q4_K_M.
Baseline: preserved ik_llama.cpp commit 2a0832d7 plus the zero-activation metadata
fix. Candidate: 0.1.2~rc4, including Q4 reuse, prefill softmax, decode registers
and FP32 final attention normalization. Baseline shared libraries were checked
against their archived hashes. The candidate uses the release's static archives;
this compares complete builds, including linkage differences.

## Method

Three pairs, ordered baseline/candidate, candidate/baseline, baseline/candidate.
Only one model is resident at a time. Each process tests all four decode cases,
then all four prefill cases, using a fresh context for each. Model loading,
repacking, deterministic KV seeding, warmup, logit capture and validation are
outside the timer. Model file cache is advised away after loading in both builds.

- Prefixes: 1024, 8192, 15360, 23552 tokens.
- Decode: 64 fixed input tokens per sample; capacity prefix + 512; batch/microbatch
  64; two projection threads, four batch threads; candidate adaptive attention.
- Prefill: 128 new tokens; capacity 24576; batch 2048, microbatch 512; four threads.
- Both: F16 KV, runtime repacking, CPU inference, OpenMP close/cores/PASSIVE.
- Decode rate: 192 tokens divided by summed timed durations across three runs.
- Prefill rate: 128 divided by median elapsed time across three runs.
- Gains are calculated from unrounded rates.

Previous headline decode tests used 16 tokens per sample. These use 64 to reduce
short-run variability, so changes from old headline rates are not isolated
measurements of the latest kernels. Prefill retains the original 128-token task.
The numbers are incremental synthetic-context throughput, not real-prompt
prefill from empty or sustained HTTP generation.

## Validation and environment

Every warmup matched the first timed output exactly. All 64 decode logit vectors
matched across builds and repetitions at every context length. Final prefill
logits repeated exactly within each build. Cross-build prefill equality is not
required: rc4 intentionally removes FP16 final-normalization rounding. New KV
bytes and post-prefill continuation are not compared by this timing harness;
those changes have separate integration validation.

All 48 samples: 0 timed major page faults. Peak sampled process swap:
0 KiB; peak sampled RSS: 2655232 KiB. Recorded CPU frequency
was at least 2400000 kHz; maximum end-of-sample temperature was 68.85 C.
These are endpoint temperature/frequency readings, not continuous throttle tracing.
Three repetitions on one machine do not establish a statistical confidence interval.
The 0.5% decode gain at 1K is small relative to run-to-run variation and should
not be interpreted as a demonstrated short-context speedup.

## Reproduction

Compile `pi5/tests/throughput_compare.cpp` against each engine's headers and
libraries, with `-std=c++20 -O2 -mcpu=cortex-a76 -fopenmp`. Define `PI5_BENCH`
only for the candidate. Link the baseline shared libraries with an explicit
library search path; link candidate libllama.a/libggml.a with
`-static-libstdc++ -static-libgcc`. Stop other model servers. Run each executable
as `HARNESS MODEL OUTPUT_DIRECTORY` in the alternating order above with the
specified OpenMP settings. The output directory must exist.

`results.csv` contains all timings and output hashes; `summary.json` aggregates
them; `environment.json` records build/model hashes and settings. Large raw
logits and process-memory samples remain in the local ignored build directory.
