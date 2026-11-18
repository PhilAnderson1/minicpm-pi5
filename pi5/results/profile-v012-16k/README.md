# v0.1.2 profile at 16K

Private operation tracing against the validated v0.1.2/rc4 engine, measured
2026-11-17 on the 4 GB Pi 5. No production engine or service changes.

| Measurement | Prefill 128 tokens | Prefill 512 tokens | Decode 64 steps |
|---|---:|---:|---:|
| Release throughput (tokens/s) | 17.70 | 17.38 | 4.74 |
| Attention (%) | 67.86 | 68.37 | 40.69 |
| Projections (%) | 31.03 | 29.94 | 55.80 |
| Other graph operations (%) | 0.93 | 1.50 | 3.09 |
| Q4 projections, included above (%) | 26.12 | 25.15 | 38.58 |
| Q6 projections, included above (%) | 4.91 | 4.78 | 17.22 |

Unattributed time outside graph groups is approximately 0.2–0.4%. Projection
classification uses actual input weight types, including fused operations.
The fused feed-forward up/gate operation accounts for about 15–16% of prefill
and 23% of decode. Decode's final vocabulary projection accounts for about 8%.

## What the profile supports

- **Prefill attention remains the largest target.** A hypothetical 10% reduction
  in its elapsed time would improve whole-model prefill throughput by about 7.3%.
  This is a sensitivity calculation, not a demonstrated or promised optimization.
- **Q4 is the next prefill projection target.** A 10% reduction in Q4 projection
  time would improve total throughput by about 2.6–2.7%. Q6 is under 5% of total
  prefill time; the same relative reduction there would yield about 0.5% overall.
- **Large decode projections still look bandwidth constrained.** Logical weight
  bytes divided by their traced elapsed time gives 11.87 GB/s. The earlier
  projection audit measured a two-worker streaming reference of 12.62 GB/s and
  found four projection workers slower. This profile is consistent with that
  finding, not a fresh DRAM-traffic or PMU measurement. Prefill reuses weights
  across tokens, so its logical-byte/time ratio does not imply a bandwidth limit.
- **General graph housekeeping offers limited headroom.** Other operations are
  roughly 1–1.5% of prefill and 3.1% of decode, already including their waits.
  Decode ADD groups account for about 2%, with substantial barrier waiting;
  the previous residual-add experiment achieved only a small gain.
- The measured interval after all workers finish an operation body and before
  worker zero exits its completion barrier is about 1.54% of decode time and
  under 0.01% of prefill. This is a timing proxy, not all synchronization cost
  and not a claim that it can all be removed. Active-worker waits overlap useful
  work on other workers and must not be added to wall time as available savings.

**Recommendation:** inspect attention's Q×K, softmax and value phases with fresh
phase timings/cache counters before another prototype. Current whole-model
attribution cannot select which phase has usable headroom. Do not repeat the
already rejected tile sizes, four-worker projections, activation-preparation
sharing or Q6 rewrites without new evidence. This profile identifies no new,
proven easy optimization and does not justify a broad engine rewrite.

## Method and controls

One model/context at a time, 24576 capacity, F16 KV, repacking, Pi profile,
512 microbatch, two projection threads and four prefill/attention workers.
OpenMP close/cores/PASSIVE. The 16384-token KV prefix is seeded deterministically;
loading, seeding, warmup, output capture and tracing dumps are outside timers.
This is incremental synthetic-context work, not real prompt prefill or HTTP.

The independent release executable runs three samples per workload. The private
profiler replaces only ggml.c.o with worker-local operation-group and barrier
timing; two pairs alternate tracing off/on. Kernel code, graph fusion and
arithmetic order are retained. All 12 profiler samples match independent release
logits bit for bit, including every decode step; release repeats match too.

Shares use worker zero's sequential operation-group wall intervals, including
completion barriers. They are elapsed-time attribution, not instruction counts
or pure computation. Internal wait and active-worker finish-spread measurements
are retained in summary.json; intentional idle projection workers are excluded
from active-worker aggregates. Timing itself and scheduling can perturb waits.

Median tracing-on versus tracing-off elapsed changes are +0.79%, +0.24%, +0.41%
for 128/512/decode respectively. Individual paired changes range approximately
-0.05% to +1.09%. Profiler-disabled medians differ from release by +0.16%, -0.10%,
+0.12%. These controls support a broad breakdown, not sub-percent conclusions.
Both processes had zero sampled swap and every timed evaluation had zero major
faults. Small system-wide swap events cannot be attributed to these processes.

## Artifacts and reproduction

summary.json includes type/role attribution, wait proxies and on/off controls.
The two timing CSVs preserve all 21 full-model samples. provenance.json records
source and archive hashes. Raw worker traces, tensor metadata, exact logits,
instrumentation.patch and scripts remain in local ignored build-profile-v012-16k/.
From the repository root, build with that directory's build.sh, then run run.py,
summarize.py and analyze.py, with other model servers stopped. Those scripts
use local paths and overwrite their experiment outputs; production is untouched.
