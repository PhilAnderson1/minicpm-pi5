# v0.1.2 prefill attention phases at 16K

Measured 2026-11-17 on the 4 GB Pi 5. Actual full-model calls with the same
synthetic 16K prefix and 128/512-token batches as the whole-model profile.
Private instrumentation only; production source, package and service unchanged.

## Phase split

Percentages below normalize summed worker time across Q×K, mask/softmax and
value accumulation. They exclude final normalization, query conversion and
outer-loop housekeeping; they are not whole-model wall-time percentages.

| Phase | 128 new tokens | 512 new tokens |
|---|---:|---:|
| Q×K | 42.10% | 41.96% |
| Mask/softmax | 15.25% | 15.36% |
| Value accumulation | 42.65% | 42.68% |

The mean worker time across these phases is approximately 65% of whole-model
wall time; the separate operation-group profile attributed about 68% to
attention including its other work and synchronization. These quantities have
different timing boundaries and should not be equated exactly.

## Sampled counters

Six per-thread hardware events, read for every 61st query-head/key tile. A prime
sampling interval spreads samples across the four groups and key blocks; this
is deterministic sampling, not random sampling. Timers measure every phase in
a separate mode. Counter reads exclude kernel/hypervisor execution. Probe
instructions and their user-space cache accesses are included; counts are not
an exact accounting of kernel instructions alone. No counters were multiplexed:
all measured running/enabled ratios equal one.

Results at 512 new tokens (128-token results are similar):

| Phase | Instructions/cycle | L1 refill/access ratio | L2 refills per sampled tile |
|---|---:|---:|---:|
| Q×K | 2.95 | 1.68% | 119.9 |
| Mask/softmax | 2.03 | 1.52% | 117.7 |
| Value accumulation | 2.17 | 2.09% | 131.2 |

Q×K and values each take about 108–110 thousand cycles per sampled tile. The
value kernel retires fewer instructions (~238 thousand versus ~320 thousand for
Q×K), but takes about the same cycles. Different instruction mixes prevent
interpreting that IPC difference as proof of a scheduling defect.

L2 refill counts are substantially lower than L1 refill counts. This is
consistent with reuse within the cache hierarchy, and provides no clear evidence
that these phases saturate DRAM bandwidth. These are cache events, not measured
DRAM bytes, load-latency samples or memory-stall attribution. They cannot exclude
L1/L2 latency, load-port limits or arithmetic dependencies as limiting factors.

## Controls and correctness

An independent unmodified release executable runs two samples per batch size.
The private executable rotates modes 0 (disabled), 1 (all-phase timers), and 2
(sparse counters plus sampled timers), twice per size. PMU setup occurs in an
untimed warmup. Only the D128 attention object is replaced; arithmetic order,
FP16 KV and final FP32 normalization are unchanged. All 12 private timed outputs
match independent release logits bit for bit; release repeats and warmups match.

| Control (median elapsed change) | 128 tokens | 512 tokens |
|---|---:|---:|
| Private disabled vs release | -2.20% | -0.23% |
| Timers vs private disabled | +2.08% | +0.46% |
| Sparse counters vs private disabled | +1.62% | +0.22% |

Two repetitions support broad attribution, not sub-percent estimates. The 128-token
controls show more layout/run variation. Production and private processes both
had zero sampled swap and zero timed major faults. Context capacity 24576,
microbatch 512, four prefill workers, F16 KV and runtime weight repacking;
OpenMP close/cores/PASSIVE. This is not a real-prompt or HTTP benchmark.

## Recommendation

No obvious new cache-buffering win is established. Q×K and values remain the
largest phases; softmax is a smaller target. If continuing, inspect value-kernel
load/FMA scheduling first, checking generated assembly for whether V loads can
be overlapped better with existing FMAs without spills or changing per-output
arithmetic order. Lower IPC is a clue for that audit, not evidence that a change
will improve performance. Keep the current register tile initially.

A hypothetical 10% reduction in value-phase time would imply approximately 3%
whole-model prefill throughput improvement, using the measured ~28% wall-time
share. A similar Q×K reduction has a similar bound; softmax would yield about 1%.
These are sensitivity estimates, not promised improvements. Reject a prototype
unless complete-attention and full-model tests confirm a useful gain.

The previous eight-query ×16-output tile and one-time softmax-weight conversion
were already investigated and did not beat the adopted kernel convincingly;
this profile does not justify simply repeating those experiments. No optimization
has been implemented or deployed by this investigation.

Raw per-worker phase counts are in phases.csv; summary.json includes all totals
and controls, and the timing CSVs include every full-model sample. provenance.json
records input archive/source hashes and event mappings. Private source, logs,
large logits and build scripts remain in build-attention-phases-v012/. To replay
locally: prepare.py, build-model.sh, run.py, then analyze.py (with the model server
stopped). Scripts use local paths and overwrite their experiment outputs.
