# Decode at 23K retained context

Measured on 2026-11-14 using the same model and verified shared-library builds as
the [direct prefill comparison](../prefill-total/README.md). The baseline contains
only the zero-activation correctness fix over upstream `2a0832d7`; the candidate
engine matches `3ed2a774`. Library hashes are recorded in `environment.json`.

Three alternating pairs each decode 16 tokens after 23,552 deterministic synthetic
KV tokens. Each process loads one model, allocates a 24,064-token context, seeds
it and warms one decode step before timing. Batch/microbatch capacity is 64;
thread counts are 2/4, with the adaptive Pi profile enabled for the candidate.
FP16 KV, runtime repacking and OpenMP close/cores/PASSIVE match the earlier tests.

Only decode calls are timed. The input token sequence is fixed, not sampled.
Logits are captured outside the timer and compared byte-for-byte across all runs.
The first timed token also matches its warmup. All comparisons passed, covering
41,779,200 bytes. All six samples had zero major faults and recorded 2.4 GHz.

The summary uses total tokens / total elapsed decode time (48 tokens per build),
matching the earlier decode table rather than the prefill median aggregation.
Candidate samples ranged from 3.63 to 3.80 t/s. This is a short synthetic benchmark,
not sustained natural-language generation or an HTTP throughput measurement.

Files:

- `results.csv`: all six timed samples, including faults, temperature and frequency.
- `summary.json`: aggregate rates and total percentage gain.
- `environment.json`: settings and library, executable and harness hashes.

To reproduce, compile `pi5/tests/decode_compare.cpp` against each engine's headers
and shared libraries, using the same compile/link settings as
`pi5/tests/compare_prefill.py`. Define `PI5_BENCH` only for the candidate. Invoke
each executable as `decode_compare MODEL OUTPUT_FILE`, in orders baseline/candidate,
candidate/baseline, baseline/candidate. Set LD_LIBRARY_PATH to the corresponding
verified libraries and the OpenMP settings above. Compare all six output files
exactly, and aggregate the CSV timings as described above. Do not run both models
concurrently. Large raw logit buffers are retained locally, not committed here.
