# Decode value registers

The existing Pi decode path already shares K/V across four query heads per
worker. Grouping eight heads reduced cache refills but slowed isolated attention
by 42% because it left only two workers busy; that option was rejected.

Keeping four heads × 32 output values in registers across each 128-key block
reduced intermediate accumulator traffic while preserving FP16 arithmetic and
per-output FMA order. A five-pair confirmation at a seeded 16K prefix, with 64
decode steps per sample, improved all five pairs by 1.20–1.62%; median paired
gain was **1.40%**. Median rates were 4.651 → 4.707 tokens/s. Ratios of medians
and median paired ratios differ. The earlier 16-step screen was mixed (three
positive and two negative pairs), motivating the longer confirmation.

Every candidate sequence matched baseline logits and newly written KV bit-for-bit.
No process swap or timed major faults were observed. The short-context control
bypassed this path and established no gain. These are synthetic-prefix engine
results, not HTTP throughput claims; context-dependent KV scanning remains.

Private sources, raw CSVs, logs and archive hashes are retained locally in
`build-decode-reuse/`. Production integration validation and package hashes are
in `build-release-decode-registers/`. This change does not alter README headline
benchmarks or publish a release.
