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

## Build and run

Use 64-bit ARM Linux on a Pi 5. On Debian/Raspberry Pi OS, install the usual
build tools (`git`, `cmake`, `build-essential`) and Python 3 for the HTTP checks.
The preset targets Cortex-A76 and builds with two compiler jobs by default.
Do not compile or benchmark concurrently with a model server on a 4 GB machine.

```sh
git clone https://github.com/PhilAnderson1/minicpm-pi5.git
cd minicpm-pi5
./pi5/build.sh
./pi5/serve.sh /path/to/MiniCPM5-2B-Q4_K_M.gguf
```

Obtain the model separately and follow its distributor's license. No model
weights are included. The exact tested GGUF has SHA256:

```text
ec2d5801640099e97d8d7e8003ad4d81f336e757811f03a26173dddf386602fd
```

The launcher uses CPU inference, runtime weight repacking, `-t 2 -tb 4`, one
slot, **24,576 context tokens**, **1,024 MiB prompt cache**, FP16 KV, and Jinja.
It binds to `127.0.0.1:8080`. Set `PORT` or `HOST` to change the binding; additional
server arguments can follow the model path. The preset does not configure
network authentication—keep it on loopback unless you arrange appropriate access.

`MINICPM_PI5_BUILD_DIR` overrides the build directory in all helper scripts.
`JOBS` controls build parallelism. OpenMP binding is set to `close`, with core
places and passive waiting, matching the experiments.

## Debian installer

A mostly static **arm64 / Raspberry Pi 5** package can be built with
`./pi5/build-deb.sh`. It installs a dedicated service account, configuration and a
systemd unit enabled on first install but left stopped. Installation prints model
download/checksum instructions for `/opt/minicpm-pi5/models/`.
See the [package guide](pi5/debian/README.md) for OS requirements, build commands
and the installation tests required before a binary release.

## Validate

Stop any existing model server first. These commands do not manage systemd:

```sh
./pi5/build-tests.sh
export OMP_PROC_BIND=close OMP_PLACES=cores OMP_WAIT_POLICY=PASSIVE
./build-pi5-tests/integration_test /path/to/model.gguf short
./build-pi5-tests/decode_check /path/to/model.gguf 1024 8192 15360
python3 pi5/tests/http_smoke.py --model /path/to/model.gguf
```

The HTTP runner starts and stops its own server on port **8081** and compares
saved-cache output with equivalent live replay, including stream cancellation.
`--full` adds a real 24,500-token prefill and restore; allow about 20–30 minutes.
Without `short`, `integration_test` also tests long-context cancellation and a
24K state roundtrip, temporarily writing about 1 GiB under `$TMPDIR` (or `/tmp`).

For current-build prefill measurements:

```sh
./build-pi5-tests/prefill_check /path/to/model.gguf 23552 128
```

This uses synthetic retained KV and measures only incremental prefill. See the
[validation guide](pi5/VALIDATION.md) before interpreting timings.

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
