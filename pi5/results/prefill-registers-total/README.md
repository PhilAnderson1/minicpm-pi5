# Updated direct prefill comparison

The README prefill rows were refreshed against the preserved ik_llama.cpp
baseline, upstream 2a0832d7 plus the zero-activation correctness fix. The candidate
uses the clean `0.1.1~rc2` package's static engine libraries, including KV reuse
and register-resident value accumulation. Unlike the earlier comparison, this
compares a shared-library baseline with a mostly static candidate; results include
build/linkage differences and are not solely an isolated kernel measurement.

Both execute the unchanged `pi5/tests/prefill_compare.cpp` harness, compiled with
Cortex-A76 settings. The original baseline executable and both shared libraries
were verified against the archived hashes. Candidate archives were verified
against the clean package build's manifest. `environment.json` records these
hashes, the package hash, compiler and model hash. The candidate source HEAD
predates the uncommitted kernel integration; `provenance.json` records source
hashes identifying that change.

Three pairs alternate baseline/candidate, candidate/baseline, baseline/candidate,
with only one model process resident at a time. Each loads the model, then tests
prefixes 0, 1024, 8192, 15360 and 23552. Each fresh context has 24576 capacity,
FP16 KV, runtime weight repacking, two decode threads, four prefill threads and
512-token microbatch capacity. The measured batch contains 128 new tokens after
deterministic synthetic retained KV. Loading, seeding, warmup, output validation
and four continuation decode steps are outside the timer.

Rates are 128 divided by the median elapsed prefill time for each build. Gains
are computed from unrounded rates. All final prefill logits, canonical new KV
bytes and continuation decode logits matched exactly across builds/repetitions:
202,905,600 reference bytes were compared. Every timed call had zero major faults.
One baseline process had a peak sampled 24,112 KiB of logical swap during its
run; the other five processes had none. This is not a claim that the entire
comparison was free from memory pressure. See `provenance.json` for those peaks.

`results.csv` retains all samples; `summary.json` contains the aggregates. This
is a single-Pi, three-repetition comparison, not a statistical confidence interval
or whole-prompt-from-empty throughput claim. Decode figures were not refreshed.

To reproduce, build the pinned baseline with the correctness patch retained in
`../prefill-total/`, and build the candidate using `pi5/build-deb.sh`. Compile
`pi5/tests/prefill_compare.cpp` against each engine's own headers: without
`PI5_BENCH` against the baseline shared libraries; with `-DPI5_BENCH` against the
candidate's `src/libllama.a` and `ggml/src/libggml.a`, using `-static-libstdc++
-static-libgcc`. Use `-std=c++20 -O2 -mcpu=cortex-a76 -fopenmp` for both harnesses.
Run each harness as `HARNESS MODEL OUTPUT_DIRECTORY` in the alternating order
above, with OpenMP `close`/`cores`/`PASSIVE`; compare the output `.bin` files
exactly and aggregate the timing CSVs. Stop other model servers first.
