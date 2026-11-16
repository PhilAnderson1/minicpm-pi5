# Implementation and scope

This fork retains the general-purpose engine. `--pi5-minicpm` is an opt-in
context/backend setting, not a process-global experiment flag. The guard requires
AArch64, the tested LLaMA-family model shape (42 layers, 2048 embeddings, 16 query
heads, two KV heads, D128), CPU execution, one sequence, flash attention, FP16 K/V
and initial thread counts 2/4. Shape compatibility is checked; the filename alone
is not trusted. The guard does not verify a model SHA256 or prove that a different
model with matching dimensions is supported.

## Cache and scheduling

K/V is stored contiguously by head for the profile, improving the access pattern
of the attention kernels. State serialization remains canonical token-major;
row conversion avoids a second full-size temporary conversion buffer. Copy,
shift and defragmentation paths respect the physical layout.

Decode below 4096 retained tokens uses two workers. At and above that threshold,
projections use two workers and attention uses four head groups. Prefill keeps
four workers. Cancellation is propagated per operation group, incomplete
microbatch cells are removed, and pending cache maintenance completes before
cancellation is acted on. These behaviors have dedicated engine checks.

Prompt-cache eviction happens before allocating a replacement state. This reduces
transient memory pressure; it does not make the requested 24K/1GiB configuration
comfortably fit in 4 GB. State formats and FP16 precision are retained.

## Arithmetic kernels

The ARM D128 Q×K helper names 24 FP16 vector accumulators explicitly, avoiding
redundant compiler-generated stack writes while retaining multiply/FMA/reduction
order. The D128 value specialization processes 32 output dimensions together,
reusing converted softmax weights. It retains the previous per-output key order
and scaling. Both are shape-selected ARM paths and can affect compatible calls
without `--pi5-minicpm`; they are not claimed to improve other ARM processors.

With `--pi5-minicpm`, supported prefill shapes reuse each 128-key block across
four query heads per worker, processing 64 query rows per head. Independent
softmax and output state survives between blocks; score scratch is shared within
the worker. This preserves arithmetic order and FP16 KV. The path requires four
workers, D128, 16 query heads, two KV heads and aligned query/key lengths;
unsupported shapes use the existing implementation. Decode scheduling is unchanged.

The activation quantizer now initializes metadata for zero blocks. This is a
correctness fix, not a KV quantization change. Runtime repacking still uses the
model's Q4_K/Q6_K weight representations and their internal repacked equivalents.

No private experimental global selectors are part of the published engine.
Mask/softmax fusion and dynamic prefill queues were investigated and rejected.
The separate commits listed in ENGINE_REVISIONS.txt preserve the profile,
Q×K and value steps for review and historical comparisons.

## Known numerical issue

Cold batched prefill and replay of its last token can produce different logits
and greedy continuation in the original implementation. The same issue reproduced
with the optimized kernels: 4,177,920 diagnostic old/new logits matched bitwise.
Live one-token replay matched restored one-token replay exactly. This isolates
the observed difference from cache serialization and the new Q×K change, but does
not establish the deeper cause or assert that it is harmless rounding.

The HTTP test therefore checks equivalent live/replayed paths, retaining exact
output comparisons rather than comparing two different evaluation paths. A
separate batch-versus-single-token correctness investigation remains worthwhile.
