# Historical decode-gap investigation

Measured 2026-11-17. The original optimized Pi serving engine was recovered from
a rollback archive: libggml.so hash 8cc847683d70f8a6d1d2f0be2d21e1fe5de5f84faa7ee3b3d2e481a45be6965a
and libllama.so hash 6171e27f4101899dc90df74d777ef258867157e26c3e75adbd8474015a129dfe.
Both match the initial serving manifest. This is the original **optimized Pi
engine**, not unmodified upstream. The historical 23K README row used a later
shared-library build; do not attribute that row to this recovered library.

## Common-harness comparison

Original shared-library engine, v0.1.1 mostly static engine, and v0.1.2
(rc4-identical engine) mostly static engine. Linkage differs between the original
and packaged engines, so this does not isolate source from build/linkage effects.
Three rounds rotate original/previous/current, current/original/previous,
previous/current/original. Each process tests all four prefixes at 16 and 64 steps;
sample-length order reverses in the middle round. Settings and harness match the
release-to-release comparison: F16 KV, repacking, Pi profile, thread counts 2/4,
batch/microbatch 64, context capacity prefix+512, one warmup step before timing,
OpenMP close/cores/PASSIVE, fixed input tokens and deterministic synthetic KV.

| Prefix | Sample tokens | Original t/s | v0.1.1 t/s | v0.1.2 t/s | v0.1.2 vs original |
|---:|---:|---:|---:|---:|---:|
| 1024 | 16 | 7.874 | 7.599 | 7.540 | -4.25% |
| 1024 | 64 | 7.745 | 7.761 | 7.712 | -0.42% |
| 8192 | 16 | 5.733 | 5.715 | 5.929 | +3.42% |
| 8192 | 64 | 5.729 | 5.746 | 5.828 | +1.73% |
| 15360 | 16 | 4.653 | 4.668 | 4.771 | +2.55% |
| 15360 | 64 | 4.668 | 4.647 | 4.727 | +1.26% |
| 23552 | 16 | 3.832 | 3.783 | 3.969 | +3.56% |
| 23552 | 64 | 3.830 | 3.838 | 3.973 | +3.74% |

All logits match exactly across the three engines and repetitions, and common
steps match between sample lengths. No process swap was observed. Two timed
major faults occurred, both in original-engine 1K/16 samples (rounds 0 and 2).
Those samples are retained and flagged, not silently excluded. The remaining
70 samples had no timed major faults. Endpoint CPU frequency was 2.4 GHz.
The original build used -march=native alongside -mcpu=cortex-a76; the package
builds omit -march=native. These settings expose identical compiler feature
macros on the current Pi, which does not prove identical generated code.

## Unchanged historical-test replay

The original benchmark executable's hash also matched its archived manifest.
It was rerun unchanged with the exact original libraries and original OpenMP
settings. It holds stock and Pi contexts together, alternating three 16-token
samples per mode. This differs from the common harness's separate processes
and logit collection, but matches the historical 1K/8K/15K measurement method.

| Prefix | Historical Pi t/s | Replayed Pi t/s | Change |
|---:|---:|---:|---:|
| 1024 | 8.146 | 7.837 | -3.79% |
| 8192 | 6.048 | 5.780 | -4.43% |
| 15360 | 4.996 | 4.624 | -7.45% |

The archived benchmark's exact-logit assertions passed. No process swap was
observed. One timed major fault occurred in the first stock 1K sample; every Pi
sample was fault-free. Frequency samples were 2.4 GHz. Raw rows include both
stock and Pi results; the table above shows only the optimized Pi path.

## Conclusion and limits

The historical rates are not reproduced even by the unchanged executable,
libraries and 16-token method. Neither newer-engine code nor changing sample
length can therefore fully account for the gap. Current matched comparisons
show no broad decode regression: v0.1.2 is approximately level at 1K/64 and
1.3–3.7% faster at 8K–23K/64 than the original engine. The short 1K result remains
variable/slower and should not be dismissed; see the separate focused follow-up.

The precise historical cause is unresolved. The original user measurements ran
in a terminal as root; this replay runs in the agent execution environment as
philip (session cgroup, autogroup nice 0). Earlier background load, scheduling,
thermal and memory-frequency conditions were not fully recorded. These are
possible confounders, not demonstrated causes. A terminal replay outside the
agent would be the next way to separate execution environment from wider host
conditions. No production code or configuration was changed.

The current README tables remain the fresh matched upstream-versus-v0.1.2
comparison. Do not mix these original optimized-engine results into that baseline.
Raw memory samples and large logit dumps remain in ignored build-historical-decode/.
The common harness is the same as ../decode-release-ab/harness.cpp, compiled
against the corresponding headers/libraries; original uses its archived shared
libraries, newer engines use their verified static archives. environment.json
records hashes. The archived executable itself is retained locally, not bundled.
