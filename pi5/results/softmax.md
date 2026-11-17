# Pi prefill softmax

The per-row range check and four-vector exponential scheduling retain the
existing polynomial, summation order and fallback. Compared with the current
Q4-reuse build, three alternating pairs per shape gave:

| Existing context | New tokens | Baseline t/s | Candidate t/s | Median paired throughput gain |
|---:|---:|---:|---:|---:|
| 0 | 128 | 54.18 | 53.95 | -0.43% |
| 0 | 512 | 51.48 | 51.51 | +0.01% |
| 16,384 | 128 | 17.38 | 17.73 | +2.02% |
| 16,384 | 512 | 16.89 | 17.28 | +2.25% |
| 16,384 | 65 | 14.97 | 14.90 | -0.50% |

The gain column is the median of paired throughput ratios, not the ratio of
throughput medians. All six 16K pairs improved. Short-context variation does
not establish a gain; the first short baseline had one major fault. No process
swap was observed. The 65-token case bypasses the specialization and is a
fallback check, not a performance result.

The 16K prefix is deterministic seeded KV, not a real prompt timed from empty.
These are private full-model prefill screens, not HTTP serving benchmarks or
new headline README claims. All 26 evaluations matched independent logits,
new KV bytes and four subsequent decode steps bit-for-bit. The prototype also
passed 1,536 block-state comparisons across three scheduling variants.

Raw experiment sources, CSVs, logs and archive hashes are retained locally in
`build-softmax-audit/`. Production package validation is retained separately
in `build-release-softmax/`; its single-run timings are correctness checks,
not new performance claims.
