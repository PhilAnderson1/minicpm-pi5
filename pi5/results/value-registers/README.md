# Register-resident value accumulation

The Pi prefill value kernel holds four queries × 32 output dimensions in
16 SIMD accumulators across a 128-key block. It preserves per-output FMA order,
FP16 conversions and scaling. Keeping the helper out of line is intentional:
GCC introduced accumulator spills when it was inlined into the attention driver.
The final candidate's key loop has no stack accesses.

Three alternating pairs in the same process compared the actual old release
object with the integrated candidate. Both used the same model/context and were
checked against independent production references: final prefill logits, new
KV bytes and four continuation decode vectors matched bitwise. Test-only linker
wrapping selected the implementation; it is not part of the serving engine.

| New tokens after a synthetic 16K prefix | Previous kernel | New kernel | Gain |
|---|---:|---:|---:|
| 128 | 15.921 t/s | 17.172 t/s | 7.86% |
| 512 | 15.182 t/s | 16.782 t/s | 10.54% |

Gains are ratios of median rates. Individual paired gains ranged from 4.00–10.02%
and 7.02–12.73% respectively. This is a small sample. All timed model calls had
zero major faults and zero process swap. Raw CSVs retain dispatch counts and
sampled temperatures/frequencies. The baseline already includes the earlier
KV-reuse optimization; these are incremental gains, not comparisons with upstream.

The integrated candidate passed full engine cancellation/state checks, 24K cache
restoration, six attention shapes and full HTTP validation with the 24K/1GiB
configuration. Its recorded HTTP binary hash matched the validated artifact.
Real 24,500-token prefill took 1,148.79 seconds overall (21.36 prompt tokens/s);
saved long-prompt restoration took 2.80 seconds, evaluating one prompt token.
Those HTTP timings are observations, not a controlled throughput comparison.

This evidence applies to the isolated serving candidate. The subsequent clean
package build is checked separately before installation.
