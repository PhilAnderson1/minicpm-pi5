# v0.1.1 versus rc4 decode investigation

Measured 2026-11-17 on the same 4 GB Raspberry Pi 5. This tests for a regression
between releases, not total gain over upstream ik_llama.cpp.

The preserved v0.1.1 engine archives matched their original validation hashes.
The final v0.1.1 package executable matched the validated rc2 executable hash.
Both harnesses use identical compiler/link options and mostly static linkage.
Public API/context/cache headers are unchanged between v0.1.1 and the current
worktree; the same harness and headers were used for both engine archives.

## Matched matrix

Three pairs in previous/current, current/previous, previous/current order.
Each process tests 1K, 8K, 15K and 23K synthetic retained KV, using both 16 and
64 fixed-input decode steps. Each prefix gets a fresh context; the two sample
lengths truncate back to the same prefix and warm one step before timing.
Sample order is 16/64 in pairs 0 and 2, reversed to 64/16 in pair 1.
Capacity is prefix + 512; batch/microbatch 64; thread counts 2/4; Pi profile;
FP16 KV; repacking; OpenMP close/cores/PASSIVE. Model loading, seeding, warmup,
logit capture and output validation are excluded from timed decode calls.
Rates are total tokens divided by summed timed durations across three samples.

| Context | Sample tokens | v0.1.1 t/s | rc4 t/s | Change |
|---:|---:|---:|---:|---:|
| 1024 | 16 | 7.756 | 7.327 | -5.53% |
| 1024 | 64 | 7.541 | 7.671 | +1.72% |
| 8192 | 16 | 5.667 | 5.660 | -0.11% |
| 8192 | 64 | 5.707 | 5.832 | +2.19% |
| 15360 | 16 | 4.647 | 4.641 | -0.13% |
| 15360 | 64 | 4.677 | 4.761 | +1.80% |
| 23552 | 16 | 3.842 | 3.935 | +2.43% |
| 23552 | 64 | 3.848 | 3.950 | +2.64% |

All logits match bit for bit across releases and repetitions; each 16-token
sequence also matches the first 16 steps of its 64-token counterpart. All 48
timed samples have zero major faults, and process monitoring shows zero swap.
CPU endpoint frequency readings were 2.4 GHz. Raw per-pair changes are preserved
in summary.json; three pairs do not establish confidence intervals.

## Focused 1K follow-up

The -5.5% initial 16-token result warranted a recheck. Three further alternating
pairs use a fresh 1K context, then run 16, 64 and 16 tokens sequentially, resetting
to the same prefix and warming one token before each. This harness additionally
records per-step timings outside the timed calls. Instrumentation/code-layout
and timing conditions differ slightly from the matrix; it is a diagnostic
follow-up, not a replacement for the initial samples.

| Phase | v0.1.1 t/s | rc4 t/s | Change |
|---|---:|---:|---:|
| First 16 tokens | 7.736 | 7.641 | -1.22% |
| 64 tokens | 7.784 | 7.724 | -0.78% |
| Repeated 16 tokens | 7.846 | 7.823 | -0.30% |

All follow-up logits agree exactly; there were zero timed major faults. This
follow-up did not continuously monitor swap, unlike the full matrix.

## Interpretation

There is no demonstrated broad decode regression from v0.1.1 to rc4. The full
matrix's 64-token samples improve by 1.7–2.6%; 23K improves in every matched
pair for both sample lengths. The short 1K signal is sensitive to run/warmup
conditions: its initial -5.5% result shrank to -1.2% initially and -0.3% after
longer exercise in the follow-up. A small short-context penalty is not ruled out;
this does not establish a specific cause such as governor or cache effects.

The previous release itself does not consistently reproduce the historical
README decode rates. Those older figures predate the v0.1.1 prefill work and
used different runs/builds and shorter samples. This experiment therefore does
not explain the entire historical gap, and does not prove that all differences
were caused by sample length. Retain rc4 on this evidence; do not replace the
upstream-comparison README table with this different release comparison.

## Reproduction and artifacts

Build harness.cpp against each release archive with the same flags:
`-std=c++20 -O2 -mcpu=cortex-a76 -fopenmp -DPI5_BENCH`, engine include paths and
`-Ipi5/tests`, linking libllama.a/libggml.a with `-static-libstdc++ -static-libgcc`.
Run `HARNESS MODEL OUTPUT_DIRECTORY REVERSE` with the server stopped and the
OpenMP settings above. REVERSE=0 selects 16/64, REVERSE=1 selects 64/16.
short-harness.cpp uses the same interface but always runs 16/64/16 at 1K.
The published source differs from the compiled source only in its include path.

results.csv, summary.json and environment.json preserve the matrix data and
hashes. short-results.csv and short-summary.json preserve the follow-up. Large
raw logits, per-step timing CSVs and memory samples remain in the local ignored
build-decode-release-ab directory. No server configuration or engine source
was changed by this investigation.
