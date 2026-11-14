# Contributing

This fork targets MiniCPM5-2B-Q4_K_M on a 4 GB Raspberry Pi 5, while retaining
upstream features for other users. Keep optional profile behavior behind explicit
configuration and restrict architecture-specific kernels to compatible shapes.

For a performance change, describe the workload and baseline, provide alternating
repetitions and raw timings, check exact logits and new KV where appropriate,
and report faults/memory pressure. Do not benchmark during compilation or with
another model process active. A cleaner kernel or less waiting is not itself
proof of faster full-model inference.

Keep FP16 KV and existing arithmetic semantics unless a precision-changing
feature is explicitly proposed and documented. Cache, cancellation and layout
changes need state/shift/defragmentation tests, not just speed measurements.
Preserve the general upstream source rather than deleting unrelated features.

Do not commit model weights, generated binaries, private keys, credentials or
raw user conversations. Generated runtime results belong in ignored build/output
directories; intentionally curated synthetic CSVs can go under pi5/results.
