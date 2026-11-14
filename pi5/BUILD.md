# Build from source

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

