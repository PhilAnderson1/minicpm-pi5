# Packed key tiles with fused attention

2026-11-18, Raspberry Pi 5 / Cortex-A76 / 4 GB, validated 0.1.3~rc2 reference.
Private prototype only; not integrated or packaged.

The producer copies each 128-key tile into dimension-major groups of six keys,
so each eight-dimension slice of the six key vectors is contiguous. Packing
covers the first 126 keys; the existing generic two-key tail is unchanged.
Each packed tile is reused across the four query heads assigned to a worker.
The 4-query × 6-key kernel, per-output FP16 multiplication/FMA order, horizontal
reduction and fused-softmax arithmetic are unchanged. The per-worker packed
buffer reserves 32 KiB. Its copying and consumption are inside the timed call.

## Complete-attention screen

Synthetic causal 16K prefix, four workers, 128/512 new queries; six rotated
samples per variant across two PMU groups. Median slowest-worker latency.

| Variant | 128 ms | Throughput change | 512 ms | Throughput change |
| --- | ---: | ---: | ---: | ---: |
| Production | 101.34 | — | 415.37 | — |
| Unchanged private clone | 101.38 | -0.04% | 414.11 | +0.30% |
| Direct pointers, unpacked | 100.01 | +1.33% | 412.32 | +0.74% |
| Direct pointers, packed | 101.68 | -0.33% | 419.92 | -1.08% |

The direct-pointer control separates packing from the earlier setup/output
specialization, which again gives only a small attention-level change. Packing
was slower than both production and the unpacked control despite fewer retired
instructions. The experiment does not prove a particular cache bottleneck.
Raw outliers remain in the dataset; no full-model gain is claimed or tested.

60 direct packed/unpacked score comparisons passed bitwise, including padded
key strides. All complete-attention output floats matched the generic reference
at both shapes. No PMU counter multiplexing. The existing reference includes the
lane-FMA and fused-weight improvements. Keep production unchanged.

Variant IDs: 1 production, 2 unchanged private clone, 3 direct/unpacked,
4 direct/packed. Private generator, sources, build commands and executable remain
under `build-packed-keys-fused/`.
