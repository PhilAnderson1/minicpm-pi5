# minicpm-pi5

MiniCPM5-2B can be surprisingly useful for coding and agentic tasks offering up to
24K tokens of available context on a Raspberry Pi 5 with just 4 GB of RAM.
`minicpm-pi5` is a fork of [ik_llama.cpp](https://github.com/ikawrakow/ik_llama.cpp)
tuned for this setup, improving throughput especially at longer context lengths.

## Measured results


Measured with MiniCPM5-2B-Q4_K_M on a **4 GB Raspberry Pi 5**.

**Token generation (decode)**

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 7.95 tokens/s | 8.15 tokens/s | 2.4% |
| 8K | 5.06 tokens/s | 6.05 tokens/s | 19.4% |
| 15K | 3.77 tokens/s | 5.00 tokens/s | 32.4% |
| 23K | 2.93 tokens/s | 3.74 tokens/s | 27.5% |

**Prompt processing (prefill)** — processing 128 new tokens after each retained
context:

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 42.23 tokens/s | 45.21 tokens/s | 7.1% |
| 8K | 18.82 tokens/s | 23.57 tokens/s | 25.3% |
| 15K | 12.11 tokens/s | 15.31 tokens/s | 26.5% |
| 23K | 8.21 tokens/s | 10.96 tokens/s | 33.5% |

Both comparisons use synthetic retained context and three alternating runs per
engine. [Methods and raw results](pi5/PERFORMANCE.md).

## Install

1. Download the latest install package from [releases](https://github.com/PhilAnderson1/minicpm-pi5/releases/latest) and install it with:

   ```sh
   sudo apt install ./minicpm-pi5_0.1.0_arm64.deb
   ```

2. Download the model:

   ```sh
   sudo curl -fL https://huggingface.co/openbmb/MiniCPM5-2B-GGUF/resolve/main/MiniCPM5-2B-Q4_K_M.gguf \
     -o /opt/minicpm-pi5/models/MiniCPM5-2B-Q4_K_M.gguf
   ```

3. Start the server:

   ```sh
   sudo systemctl start minicpm-pi5
   ```

Open **http://localhost:8080** on the Pi or connect your client to port 8080. Settings: `/etc/default/minicpm-pi5`.
The service starts automatically on subsequent boots.

[Settings and troubleshooting](pi5/debian/README.md) ·
[Build from source](pi5/BUILD.md)

## What changes

- KV cache layout and thread scheduling tuned for the Pi 5 CPU.
- Faster attention kernels for prompt processing.
- Cache restore, context shifting and cancellation support for the optimized layout.
- Prompt-cache eviction before replacement allocation to reduce memory peaks.
- A correctness fix for zero-valued activation quantization blocks.

Model weights remain Q4_K_M and the KV cache remains FP16. The optimized profile
is tested for CPU inference with one sequence at a time.

[Implementation and known limitations](pi5/DESIGN.md) ·
[Run tests](pi5/VALIDATION.md) · [Build the installer](pi5/debian/PACKAGING.md)

Based on ik_llama.cpp commit `2a0832d7`. The [MIT licence](LICENSE),
[upstream authors](AUTHORS) and third-party notices are retained; model licensing
is separate. [Original documentation](README.upstream.md) ·
[Contributing](pi5/CONTRIBUTING.md)
