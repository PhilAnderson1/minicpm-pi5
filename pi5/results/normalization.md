# D128 FP32 final normalization

Final attention normalization on AArch64 now converts the FP16 value accumulator
to FP32 before multiplying by an FP32 reciprocal. Decode already used this
precision. KV storage and value accumulation remain FP16. The change is scoped
to the D128 attention translation unit; other dimensions are unchanged.

The original 361-token real prompt now gives exact cold-prefill, live-replay,
repeat-replay and restored-replay logits. Previously all 130560 logits differed,
with maximum absolute difference 0.599659. Earlier KV entries remain unchanged.

All 24 candidate synthetic samples (six per case below) also had bit-identical
cold/replay logits. This is not a model-quality test or a guarantee for every
possible prompt. A real 4096-token HTTP test passed cold/live output equality,
cache restoration and recovery after stream cancellation.

## Timing

Four sequential processes in baseline/candidate/candidate/baseline order;
three repetitions per workload per process after warmup. Context 24576,
microbatch 512, two projection and four prefill threads, Pi profile, F16 KV.
The 16K prefix was seeded synthetically and excluded from timed computation.
Medians from six samples per implementation:

| Prefix | New tokens | Baseline ms | FP32 normalization ms | Throughput change |
|---:|---:|---:|---:|---:|
| 0 | 128 | 2396.04 | 2396.20 | -0.01% |
| 0 | 512 | 9950.51 | 9913.40 | +0.37% |
| 16384 | 128 | 7181.96 | 7190.56 | -0.12% |
| 16384 | 512 | 29422.36 | 29434.51 | -0.04% |

No meaningful performance change demonstrated. All 48 timed samples had zero
major page faults; monitoring showed zero process swap. A preliminary run that
mixed large cache snapshots with timing caused paging and was excluded.

The private prototype passed short in-process integration checks covering full
state, cross-layout restore, context shifts, defragmentation and cancellation.
The production integration adds cold/replay regression assertions to both the
in-process and HTTP tests. Local raw artifacts are in `build-normalize-f32/`;
release validation is in `build-release-normalize-f32/` (ignored build folders).

Production rc4 validation passed the new cold/replay regression and short
integration checks. Its 361-token logits and last-token KV match the tested
prototype bit for bit. Package extraction/startup-version checks passed; service
and default configuration files are unchanged from rc3.
