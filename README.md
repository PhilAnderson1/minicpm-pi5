# minicpm-pi5

MiniCPM5-2B can be surprisingly useful for coding and agentic tasks offering up to
24K tokens of available context on a Raspberry Pi 5 with just 4 GB of RAM.
`minicpm-pi5` is a fork of [ik_llama.cpp](https://github.com/ikawrakow/ik_llama.cpp)
optimised for MiniCPM5-2B on the Raspberry Pi 5’s Arm Cortex-A76 CPU,
improving throughput especially at longer context lengths.

## Measured results

Measured with MiniCPM5-2B-Q4_K_M on a **4 GB Raspberry Pi 5**.

**Token generation (decode)**

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 7.69 tokens/s | 7.68 tokens/s | -0.2% |
| 8K | 4.96 tokens/s | 5.79 tokens/s | 16.7% |
| 15K | 3.70 tokens/s | 4.78 tokens/s | 29.3% |
| 23K | 2.88 tokens/s | 3.95 tokens/s | 37.1% |

**Prompt processing (prefill)** — processing 128 new tokens after each retained
context:

| Retained context | ik_llama.cpp | MiniCPM-PI5 | Gain |
|---|---:|---:|---:|
| 1K | 42.31 tokens/s | 48.46 tokens/s | 14.5% |
| 8K | 18.98 tokens/s | 28.38 tokens/s | 49.5% |
| 15K | 12.18 tokens/s | 20.05 tokens/s | 64.6% |
| 23K | 8.69 tokens/s | 15.08 tokens/s | 73.5% |

Measured with **0.1.3**, using synthetic retained context and three alternating
runs per engine. Decode samples generate 64 tokens; prefill samples process 128
new tokens. [Methods and raw results](pi5/PERFORMANCE.md).

## Install

1. Download the latest install package from [releases](https://github.com/PhilAnderson1/minicpm-pi5/releases/latest) and install it with:

   ```sh
   sudo apt install ./minicpm-pi5_0.1.3_arm64.deb
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

- KV cache layout and thread scheduling tuned for the Cortex-A76.
- Faster attention through KV reuse across query heads and better register use
  during prefill and [decode](pi5/results/decode_registers.md).
- Fused softmax/value weight preparation and direct ARM lane-FMA instructions
  improve prefill without changing precision.
- [Q4 weight preparation reused across tokens](pi5/results/q4_reuse.md) and
  [faster prefill softmax](pi5/results/softmax.md).
- Cache restore, context shifting and cancellation support for the optimized layout.
- Prompt-cache eviction before replacement allocation to reduce memory peaks.
- **Correctness:** initialize metadata for zero-valued activation blocks.
- **Correctness:** [FP32 final attention normalization](pi5/results/normalization.md)
  makes cold prefill and cached replay agree in tested cases, with no meaningful
  performance cost.

Model weights remain Q4_K_M and the KV cache remains FP16. The optimized profile
is tested for CPU inference with one sequence at a time.

[Implementation and known limitations](pi5/DESIGN.md) ·
[Run tests](pi5/VALIDATION.md) · [Build the installer](pi5/debian/PACKAGING.md)

Based on ik_llama.cpp commit `2a0832d7`. The [MIT licence](LICENSE),
[upstream authors](AUTHORS) and third-party notices are retained; model licensing
is separate. [Original documentation](README.upstream.md) ·
[Contributing](pi5/CONTRIBUTING.md)
