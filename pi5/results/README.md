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

- `prefill-registers-total/`: refreshed direct baseline versus 0.1.1~rc2 prefill comparison previously used in the README.

- `rc4-throughput/`: previous 0.1.2 README decode and prefill comparison against the preserved baseline.

- `decode-release-ab/`: matched v0.1.1/rc4 decode comparison at 16 and 64 steps, including a focused 1K follow-up.

- `historical-decode/`: original-engine versus v0.1.1/v0.1.2 comparison and unchanged historical-benchmark replay.

- `profile-v012-16k/`: current-release operation/type breakdown with tracing controls and bounded optimization estimates.

- `attention-phases-v012/`: full-model prefill phase timings and sampled L1/L2 counters with output-parity controls.

- `value-scheduling/`: private lane-FMA candidate, exact-output checks and full-model 16K prefill gains of 3.6%/3.2%; source integrated, serving checks passed, packaged as 0.1.3~rc1.

- `qk-scheduling/`: query load-ahead and key-major Q×K schedules; no useful complete-attention gain, not adopted.

- `qk-layout/`: direct-pointer/fixed-layout Q×K screen; fewer instructions but under 1% attention gain on follow-up, not adopted.

- `softmax-value-fusion/`: direct FP16 weight production, exact-state/output checks, +5.6%/+5.4% full-model 16K prefill; source integrated; local and HTTP checks passed, packaged as 0.1.3~rc2.

- `v013-rc2-throughput/`: current README decode/prefill matrix, remeasuring baseline and fused candidate in three alternating pairs.

- `profile-fused-16k/`: refreshed operation profile of 0.1.3~rc2, with trace controls and paging caveats.
- `packed-keys-fused/`: packed-key reuse across query heads; exact outputs but no attention throughput gain, not adopted.

- `cache-blocks-fused/`: repeat 1/2/4/8-group and 128/256/512-key-span sweep with fused weights; current four-group/128-key arrangement still best.
