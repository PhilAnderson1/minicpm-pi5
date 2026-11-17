# Q4 prepared-tile reuse

The Q4 prefill kernel prepares four output rows of weights and reuses the
unpacked values and decoded scales across 64 or 128 tokens. Preparing for all
512 tokens at once harmed activation locality; bounded token groups recovered
the benefit. The largest prepared buffer is 31,104 bytes per worker.

Private full-model comparison against v0.1.1, using the same executable with
alternating baseline/candidate modes, Q4_K_M model weights and FP16 KV:

| Existing context | New tokens | Baseline t/s | Candidate t/s | Median throughput change |
|---:|---:|---:|---:|---:|
| 0 | 128 | 52.09 | 53.94 | +3.5% |
| 0 | 512 | 49.90 | 51.67 | +3.6% |
| 16,384 | 128 | 17.22 | 17.10 | −0.7% |
| 16,384 | 512 | 16.77 | 17.05 | +1.7% |

These initial results used three alternating pairs per shape. The apparent
16K/128 slowdown did not repeat: a fresh seven-pair comparison was faster in
all seven pairs, with a median paired improvement of **2.0%** (range 0.43–9.69%).
The ratio of throughput medians in that repeat was +3.0%. Large outliers in
both runs make a precise percentage unwarranted; the evidence does not justify
excluding the 128-token path as a proven regression.

The 16K prefix is a deterministic seeded KV cache, not a timed real 16K-token
prompt. All 40 full-model samples (initial and confirmation, including two
65-token fallback samples) matched independent production logits, new KV data
and four subsequent decode steps exactly. There were no observed process-swap
pages or timed major faults. Four prefill threads, two decode threads, 24K
capacity and the existing Pi profile were used.

The isolated screen covered four real model matrices, warm and displaced cache
conditions, 128/512-token batches, and 32/64/128-token reuse tiles. Preparation
cost was included. Selected variants reduced executed instructions by about 9%
and CPU cycles by roughly 7–10% on the larger matrices. Those kernel percentages
must not be described as end-to-end throughput improvements.

Raw experiments and provenance are retained locally in `build-q4-reuse`.
The integrated implementation has no experimental mode switch. Unsupported
shapes, batches below 128 and decode use the existing kernels. Final package
validation is recorded separately in `build-release-q4-reuse`.
