# Curated measurement evidence

These small CSVs preserve original synthetic benchmark timings. They are not
runtime configuration. See ../PERFORMANCE.md for baselines and limitations.

- qk-registers / value-prefill: mode0 existing vs mode1 candidate, rotated runs.
- softmax-audit: profiler controls and the rejected mask/scale candidate.
- worker-balance: profiler controls and rejected dynamic-queue measurements.
- reported-decode.csv: transcribed user-run aggregate results, not raw repetitions.
- *-http.json: timing/status-only summaries of synthetic validation requests.

No model weights, raw tensor dumps, prompts, hostname, absolute local paths or
private profiling libraries are included. Experimental selectors in CSVs refer
to historical private builds; there are no such global switches in this engine.
