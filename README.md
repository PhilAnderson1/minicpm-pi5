# minicpm-pi5

Raspberry Pi 5 optimizations for **MiniCPM5-2B-Q4_K_M** inference with
[ik_llama.cpp](https://github.com/ikawrakow/ik_llama.cpp).

This is a focused fork, retaining upstream history, general model support and
licensing. It is not a new inference engine or an official MiniCPM/Raspberry Pi
project. The original documentation is in [README.upstream.md](README.upstream.md).

## What changes

- An explicit `--pi5-minicpm` profile with head-contiguous **FP16** KV storage.
- Adaptive decode: two workers below 4,096 retained tokens; above that, two for
  projections and four for attention, with query heads divided among workers.
- FP16 prefill kernels that avoid redundant Q×K stack writes and reuse softmax
  weights across wider value tiles. Compatible ARM shapes also use these kernels
  outside the explicit profile.
- Canonical cache serialization, context shifting and cancellation recovery for
  the new layout; prompt-cache eviction before replacement allocation.
- A fix for uninitialized metadata in zero-valued activation quantization blocks.

The GGUF weights and KV precision are unchanged. No additional lossy KV
quantization or new softmax approximation is introduced. Unsupported profile
configurations are rejected explicitly. See [implementation notes](pi5/DESIGN.md).

## Measured results

On one **4 GB Raspberry Pi 5**, short synthetic decode comparisons measured:

| Retained context | Baseline | Pi profile | Gain |
|---|---:|---:|---:|
| 1K | 7.95 tokens/s | 8.15 tokens/s | 2.4% |
| 8K | 5.06 tokens/s | 6.05 tokens/s | 19.4% |
| 15K | 3.77 tokens/s | 5.00 tokens/s | 32.4% |

Controlled prefill comparisons measured the following incremental improvements
(medians of three alternating repetitions, with synthetic retained KV):

| Optimization | Retained context | New prompt tokens | Before (tokens/s) | After (tokens/s) | Gain |
|---|---:|---:|---:|---:|---:|
| Q×K accumulators | 8,192 | 128 | 20.08 | 23.19 | 15.45% |
| Q×K accumulators | 23,552 | 128 | 9.17 | 11.28 | 23.07% |
| Q×K accumulators | 23,552 | 512 | 9.11 | 11.16 | 22.46% |
| Wider value tile, after Q×K | 8,192 | 128 | 23.29 | 23.74 | 1.93% |
| Wider value tile, after Q×K | 23,552 | 128 | 11.31 | 11.70 | 3.43% |
| Wider value tile, after Q×K | 23,552 | 512 | 11.11 | 11.32 | 1.93% |

These measure processing new prompt tokens after an existing context, rather than
prefilling the entire context from empty. Each optimization was tested separately;
the rows are not one combined before/after benchmark and gains should not be added.
Generation still slows as context grows. Results are not promises for other
models or machines. [Methods, raw data and rejected experiments](pi5/PERFORMANCE.md).

## Install

Raspberry Pi 5, 64-bit Debian 13 / Raspberry Pi OS Trixie. Stop any other model
server first.

The `.deb` is built locally; the download below will work once release `v0.1.0`
is published.

```sh
# 1. Create the model directory
sudo install -d -m 0755 /opt/minicpm-pi5/models

# 2. Download the model
sudo curl -fL https://huggingface.co/openbmb/MiniCPM5-2B-GGUF/resolve/main/MiniCPM5-2B-Q4_K_M.gguf \
  -o /opt/minicpm-pi5/models/MiniCPM5-2B-Q4_K_M.gguf

# 3. Download the installer
curl -fLO https://github.com/PhilAnderson1/minicpm-pi5/releases/download/v0.1.0/minicpm-pi5_0.1.0_arm64.deb

# 4. Install
sudo apt install ./minicpm-pi5_0.1.0_arm64.deb

# 5. Start
sudo systemctl start minicpm-pi5
```

Open **http://localhost:8080** on the Pi. Settings: `/etc/default/minicpm-pi5`.
The service starts automatically on subsequent boots.

[Build from source](pi5/BUILD.md) · [Build the installer](pi5/debian/README.md) ·
[Run tests](pi5/VALIDATION.md)

## Limitations

- The tested model uses 42 layers, embedding size 2,048, 16 query heads and two
  KV heads of dimension 128. Other model configurations are not validated.
- **24K plus a 1 GiB saved cache is tight on 4 GB RAM.** Capacity tests require
  paging; the tested host uses zram with a microSD-backed writeback device.
  This repository does not configure swap. Smaller context/cache budgets may
  be more appropriate for machines with other workloads.
- The original engine can produce different output after cold batched prefill
  versus one-token prompt replay. This was reproduced before these kernel
  changes; live and restored replay matched exactly. It remains an open
  correctness/numerical investigation, not a claimed fix.
- The optimized path is single-sequence, CPU-only, FP16 KV. Multi-slot serving,
  quantized KV and other hardware are outside this profile's validation.

An optional [systemd example](pi5/minicpm-pi5.service.example) requires editing
its user and absolute paths. The source build and launch scripts do not install
a system service; the Debian package provides the managed installation described
above.

## Provenance and license

Based on ik_llama.cpp commit `2a0832d7cb57fd63ef5966760ccfd6db3994a1d9`.
Upstream's MIT [LICENSE](LICENSE), [AUTHORS](AUTHORS), and third-party notices are
retained. Model licenses are separate. The Pi additions and validation tools are
provided under the repository's MIT license. See [CONTRIBUTING.md](pi5/CONTRIBUTING.md)
for the scope of this fork and evidence expected for optimization changes.
