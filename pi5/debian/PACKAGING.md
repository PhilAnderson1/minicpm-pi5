# Build and test the installer

Run these commands from the repository root on a Raspberry Pi 5 with a 64-bit
Debian-family OS. Stop other model servers before building or testing.

```sh
sudo apt install build-essential cmake python3 dpkg-dev binutils
./pi5/build-deb.sh
```

The `.deb` is written to `build-pi5-deb/packages/`. Building does not install it
or change system services.

| Build option | Default | Purpose |
|---|---|---|
| `JOBS` | `1` | Compiler jobs; use `2` with sufficient free RAM |
| `VERSION` | `0.1.0` | Debian package version; change for each release |
| `MINICPM_PI5_PACKAGE_BUILD_DIR` | `build-pi5-deb` | Build and output directory |
| `--configure-only` | — | Configure without compiling |

The executable statically links the inference libraries, libstdc++ and libgcc.
glibc, libm and OpenMP remain system dependencies. The packager checks the ARM64
architecture and library dependencies, rejects runtime library search paths, and
uses `dpkg-shlibdeps` to set minimum dependency versions. Build on the oldest OS
you intend to support, then test on each supported OS.

## Check before release

```sh
python3 pi5/debian/test_packaging.py
MINICPM_PI5_BUILD_DIR="$PWD/build-pi5-deb" \
  python3 pi5/tests/http_smoke.py --model /path/to/MiniCPM5-2B-Q4_K_M.gguf
```

The first command tests maintainer-script behaviour with stubbed system commands.
The second starts a temporary server on port 8081 and tests HTTP/cache recovery.
Neither installs the package. See the [engine test guide](../VALIDATION.md) for
additional checks.

On a disposable Pi/OS image, verify:

1. First install creates the service user and enables the unit without starting
   it. Starting without a model skips startup.
2. With the model installed, explicit startup and HTTP/cache tests pass.
3. Upgrades preserve settings and enabled/disabled state without automatically
   starting, stopping or restarting the server.
4. Removal stops the service; purge removes configuration and enablement state.
   Both retain the downloaded model and service account.

## Package layout

| Path | Contents |
|---|---|
| `/usr/lib/minicpm-pi5/llama-server` | Server executable |
| `/etc/default/minicpm-pi5` | User settings, preserved on upgrade |
| `/usr/lib/systemd/system/minicpm-pi5.service` | Service unit |
| `/usr/share/doc/minicpm-pi5/SETUP.txt` | Instructions also printed on installation |
| `/opt/minicpm-pi5/models/` | Separately downloaded weights |

The service runs as the no-login `minicpm-pi5` user. It can read but cannot change
model files. The installer does not modify an existing `llama.service`.

The tested model SHA256 is:

```text
ec2d5801640099e97d8d7e8003ad4d81f336e757811f03a26173dddf386602fd
```

## Validation recorded on 2026-11-14

The Debian 13 / GCC 14.2 build produced an approximately 11 MiB package with a
34.2 MiB executable. It requires `libc6 (>= 2.38)` and `libgomp1 (>= 4.9)`;
this binary does not support Debian 12/Bookworm.

Passed: syntax checks, mocked installation lifecycle, archive extraction,
checksums, permissions, configuration registration, server help/version and direct
engine tests for exact logits, cache/state restore, shifting, defragmentation and
cancellation recovery.

Still required before a validated binary release: actual installation lifecycle
and HTTP tests. The build session could not run HTTP or systemd verification
because sockets were restricted. No package was installed on the build host.
