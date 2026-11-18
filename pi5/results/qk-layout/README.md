# Fixed-layout Q×K setup/output investigation

2026-11-17, Cortex-A76 Raspberry Pi 5 / 4 GB. Reference is the validated
0.1.3~rc1 lane-FMA serving archive. Production sources and packages unchanged.

Private 4-query × 6-key helpers replace per-tile DataInfo row mapping and output
addressing with direct query/score pointers. Query rows are 128 FP16 elements;
score rows are 128 floats. One helper accepts a key stride; the other fixes it
at 128 FP16 elements too. The outer guard checks all required dimensions,
strides and absence of row mapping; other cases fall back to the production
GEMM. Both retain the same FP16 multiply/FMA/reduction order, tile dimensions,
and generic two-key tail. The compiler also creates constant-propagated helper
versions. Assembly extracts record those actually selected in the hot path.

## Results

Complete causal attention at a synthetic 16K prefix, four workers, OMP close/core
placement and passive waiting. Six rotated samples per variant and shape across
two PMU groups. Median latency is the slowest worker per call, not summed worker
time. An unchanged private helper controls for driver/layout differences.

| Variant | 128-token throughput change | 512-token throughput change |
| --- | ---: | ---: |
| Unchanged private helper | -0.22% | -1.52% |
| Direct pointers | +1.22% | +0.26% |
| Fixed key stride as well | +1.18% | -0.11% |

The direct-pointer version retires about 7.8% fewer complete-attention
instructions, but removes no vector arithmetic or key/query loads. Fewer scalar
instructions need not reduce the critical path; these measurements do not prove
which hardware resource limits performance.

A focused follow-up ran six alternating production/direct-pointer pairs, using
one PMU group, after compilation finished:

| New queries | Production ms | Direct-pointer ms | Throughput change |
| --- | ---: | ---: | ---: |
| 128 | 110.56 | 109.68 | +0.80% |
| 512 | 454.53 | 451.38 | +0.70% |

Individual paired changes span -1.84% to +4.14% at 128 queries and -1.70% to
+1.33% at 512. These are small possible gains, not a robust substantial win.
Full-model performance was not measured; its gain would be diluted by the
remaining operations. Keep the existing production implementation.

108 direct score comparisons per executable cover supported layouts and
unsupported-stride fallbacks. All score/output floats matched bitwise in both
runs. Every complete-attention sample matches the generic production reference.
Counter groups ran without multiplexing. Raw outliers are retained.

Private scripts and generated prototypes remain in `build-qk-layout/`.
Variant IDs: 1 production, 2 unchanged private helper, 3 direct pointers,
4 fixed key stride. `confirm.csv` contains only variants 1/3. This test does not
rule out every possible layout specialization or larger attention redesign.
