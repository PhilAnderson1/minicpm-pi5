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
The value stage holds four queries × 32 output dimensions in registers across
128 keys, reducing partial-output traffic. Its helper stays out of line to avoid
compiler-generated accumulator spills; FP16 arithmetic order is retained.

The ARM Q4_K_R4 prefill path prepares four output rows of weights once and
reuses them across 128 tokens (2048 input dimensions) or 64 tokens (6144 input
dimensions). A 31,104-byte per-worker buffer holds the largest prepared tile;
it does not expand the whole model. Supported calls use Q8_K32 activations,
contiguous rows, and at least 128 tokens in multiples of eight. The fused SiLU
gate/up path preserves the same arithmetic. Smaller or unsupported calls use
the existing kernels. Like the arithmetic specializations above, this is
shape-selected on AArch64 rather than restricted by the profile flag.

The activation quantizer now initializes metadata for zero blocks. This is a
correctness fix, not a KV quantization change. Runtime repacking still uses the
model's Q4_K/Q6_K weight representations and their internal repacked equivalents.

For Pi decode with complete 128-key tiles, four query heads retain 32 output
dimensions each in registers across a key block. This reduces intermediate
accumulator traffic while preserving FP16 FMA order and running-state rescaling.
The existing four-worker policy, KV layout and normalization remain unchanged;
other key tile sizes retain the generic kernel.

The Pi D128 prefill softmax checks each score row's range once. Rows within
[-80, 0] after subtracting the running maximum use the existing exponential
polynomial in groups of four vectors, preserving the original summation order.
Other ranges retain the generic exponential path. This changes neither score
precision nor KV storage; generic attention and decode are unaffected.

No private experimental global selectors are part of the published engine.
Mask/softmax fusion and dynamic prefill queues were investigated and rejected.
The separate commits listed in ENGINE_REVISIONS.txt preserve the profile,
Q×K and value steps for review and historical comparisons.

## Prefill/replay normalization consistency

D128 attention now performs final normalization in FP32 on AArch64, matching
decode. Previously prefill rounded the reciprocal and product to FP16, causing
cold prefill and last-token replay to differ even with intact cached state.
KV storage and attention value accumulation remain FP16. Other attention
translation units retain their existing normalization.

The original 361-token reproduction and tested 128/512-token batches at zero
and 16K prefixes now produce bit-identical cold/replay logits. The 4K HTTP test
also passed cold/live output equality, saved-cache restore and streaming
cancellation recovery. This is a consistency fix, not a measured quality or
throughput improvement. See results/normalization.md for scope and measurements.
