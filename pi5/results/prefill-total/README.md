# Direct prefill comparison

`results.csv` contains the timed samples; `summary.json` contains speeds computed
from median elapsed times and `100 × (MiniCPM-PI5 / ik_llama.cpp − 1)` gains.
`environment.json` records settings and binary/library/model hashes.
`provenance.json` records the engine revisions, matching compiler flags and
verification against preserved library manifests.

The baseline is upstream `2a0832d7` plus `baseline-correctness.patch`, the
zero-activation metadata fix also used for the decode baseline. The candidate's
engine source matches `3ed2a774` exactly. Both use shared-library Release builds
with the same Cortex-A76 compiler flags. This isolates engine changes from the
mostly static package's linking changes. The candidate's `source_head` in the
raw environment record is the original worktree base; the verified final engine
revision is recorded separately in provenance.json.

Each process loads one model and tests prefixes 0, 1,024, 8,192, 15,360 and 23,552
in that order. Prefix KV is deterministic and synthetic. At each depth a fresh
24,576-token context is seeded, one 128-token batch warms the graph, its suffix is
removed, and another identical 128-token batch is timed. Loading, seeding,
validation and four following decode steps are excluded from the prefill timer.

There are three repetitions per build, in orders baseline/candidate,
candidate/baseline, baseline/candidate. Only one model process runs at a time.
Both use FP16 KV, weight repacking, two decode threads, four prefill threads,
512-token microbatches, and OpenMP close/cores/PASSIVE.

Each timed prefill must match its warmup logits exactly. Across all builds and
repetitions, final-token prefill logits, all newly written KV bytes in canonical
order, and logits from four following decode steps must match the first baseline
run exactly. Raw comparison buffers remain local under the benchmark output
directory; they are not included in this repository.

These are incremental prefill speeds after retained context, not the average
speed of processing a whole prompt from empty. All nonempty-context samples had zero major faults. The first empty-context
baseline sample had 24; the small empty-context gain is within the observed
baseline variation. Frequency samples were all 2.4 GHz and temperatures stayed
between 49.6 and 65.0°C. All 202,905,600 compared reference bytes matched.

## Reproduce

Build the pinned baseline with the supplied correctness patch, and the final
engine as shared libraries, using matching Release/Cortex-A76 settings. Stop
other model servers. From this repository root run:

```sh
python3 pi5/tests/compare_prefill.py \
  --model /path/to/MiniCPM5-2B-Q4_K_M.gguf \
  --baseline-source /path/to/baseline \
  --baseline-lib-dir /path/to/baseline/build/src \
  --baseline-lib-dir /path/to/baseline/build/ggml/src \
  --candidate-source /path/to/minicpm-pi5 \
  --candidate-lib-dir /path/to/minicpm-pi5/build-pi5/src \
  --candidate-lib-dir /path/to/minicpm-pi5/build-pi5/ggml/src \
  --output build-prefill-comparison/new-run
```

The output directory must be empty. The runner builds the same harness against
each set of headers and libraries, verifies library resolution, checks results,
and writes the timing summaries. Allow roughly ten minutes on the tested Pi.
