# Q×K load scheduling investigation

2026-11-17, Raspberry Pi 5 / Cortex-A76 / 4 GB. Reference: the validated
0.1.3~rc1 lane-FMA serving archive. No production code was changed by this test.

The existing D128 4-query × 6-key kernel retains 24 FP16 vector accumulators,
with 24 FMAs per inner iteration and no hot-loop accumulator spills or weight
broadcasts. It holds six key vectors and loads one query vector at a time.

Two private variants retain exactly the same multiply, FMA and reduction order
for every output:

- Query load-ahead: load the next query before the current query's six FMAs.
- Key-major: retain four queries, load keys ahead, and apply each key across
  the four queries before advancing. This reduces operand-register pressure.

Assembly confirms different schedules and no hot-loop spills. Both still do
24 vector FMAs and ten vector loads per iteration. Neither removes arithmetic
or memory traffic. Out-of-order execution may already hide much of the apparent
load latency; the experiment does not establish a specific hardware bottleneck.

## Complete-attention results

Causal synthetic 16K prefix, four workers, 128/512 new queries, six samples per
variant with rotating order (two PMU groups × three repetitions). Reported
latency is median slowest-worker time. OMP close/core placement, passive waiting.

| Variant | 128-query ms | Throughput change | 512-query ms | Throughput change |
| --- | ---: | ---: | ---: | ---: |
| Production | 111.81 | — | 460.14 | — |
| Unchanged private kernel | 111.93 | -0.10% | 463.17 | -0.65% |
| Query load-ahead | 112.36 | -0.48% | 458.87 | +0.28% |
| Key-major | 113.67 | -1.63% | 459.82 | +0.07% |

The private control uses the same extracted kernel but a private driver and
calls the original generic kernel for the two-key tail. It therefore measures
small layout/driver differences as well as the unchanged inner kernel. Gains
relative to that control do not establish gains over production.

All 90 direct Q×K comparisons matched bitwise, including padded key/query/output
strides. Every float of every timed complete-attention output matched the
production generic reference, with current FP32 normalization and lane-FMA value
kernel. No counters were multiplexed. Raw samples, including outliers, are kept.

Decision: retain production Q×K. The near-zero or negative attention results do
not justify a full-model or serving build. This rules out these two narrow
schedules, not all possible Q×K optimizations. No deployment or new package.

Private reproducibility: `prepare.py`, `build.sh`, `bench.cpp`, `kernels.cpp`.
Run `OMP_PROC_BIND=close OMP_PLACES=cores OMP_WAIT_POLICY=PASSIVE ./bench` with
no model server or concurrent build, then `python3 summarize.py`. Variant IDs:
1 production, 2 private clone, 3 query load-ahead, 4 key-major.
