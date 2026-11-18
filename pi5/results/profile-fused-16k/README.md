# Fused-engine 16K profile refresh

2026-11-18, Raspberry Pi 5 / Cortex-A76 / 4 GB. Reference: validated 0.1.3~rc2.
No production source or installed-service changes in this investigation.

| Measurement | Prefill 128 | Prefill 512 | Decode 64 |
| --- | ---: | ---: | ---: |
| Release tokens/s | 19.81 | 19.31 | 4.76 |
| Attention % | 64.77 | 65.47 | 41.29 |
| Projections % | 33.92 | 32.67 | 55.73 |
| Other graph operations % | 1.09 | 1.65 | 2.62 |

Attention remains the largest prefill cost; projections remain the largest
decode cost. Q4 projections account for 27–28% of total prefill time, Q6 for
5–6%. The graph categories include waits and are broad wall-time attribution,
not independent recoverable compute costs. Earlier v0.1.2 attention shares were
about 68%; the smaller share here is consistent with the subsequent improvements.
This is not a paired release-performance comparison or a new README benchmark.

## Controls and limitations

Same harness as the v0.1.2 profile: synthetic 16,384-token KV prefix, 24K capacity,
FP16 KV, repacking, ub512, t2/tb4, OMP close/core placement and passive waiting.
Independent release: three samples per workload. Private profiler: two alternating
tracing-off/on pairs, replacing only ggml.c.o in a copied archive. All 12 private
samples matched independent release final logits exactly. This profiler does not
compare new KV bytes or every intermediate decode logit.

Tracing median runtime changes were +0.13%, -1.11% and +1.22% for prefill128,
prefill512 and decode; profiler-off versus release was +0.53%, +0.67%, -0.93%.
Negative overhead reflects measurement variation, not a tracing speedup.
No benchmark-process swap was sampled. Release samples had no timed major
faults. One private 128-token tracing-off sample had one major fault; traced
samples had none. System-wide swap counters did show activity in some intervals,
including decode, and must not be described as benchmark-process swap or ignored
when interpreting small timing differences. Broad attribution remains useful;
small percentage differences are not strong evidence of a speed change.

An agent/server restart interrupted the first attempt. That incomplete attempt
is retained privately under `interrupted/` and excluded from these results.
All reported results come from the clean rerun. Raw worker traces, node metadata,
large logits and memory samples remain in `build-profile-fused-16k/`.

## Follow-up

The selected bounded experiment packed each 128-key tile once for reuse across
four query heads. Its complete-attention comparison includes all packing costs.
It matched outputs exactly but did not improve throughput; retain production.
See [packed-key results](../packed-keys-fused/README.md).
