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

- `prefill-total/`: direct baseline versus final-engine prefill comparison,
  including raw samples, provenance and reproduction instructions.
- `decode-23k/`: matched 23,552-token decode comparison with raw repetitions
  and exact-logit checks.

- `kv-prefill/`: incremental KV-reuse prefill measurements and candidate validation.

- `value-registers/`: incremental register-resident value kernel measurements and serving validation.

- `prefill-registers-total/`: refreshed direct baseline versus 0.1.1~rc2 prefill comparison used in the README.
