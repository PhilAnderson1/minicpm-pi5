# Debian package

Build on a Raspberry Pi 5 running a 64-bit Debian-family OS:

```sh
sudo apt install build-essential cmake python3 dpkg-dev binutils
./pi5/build-deb.sh
```

The build uses one compiler job by default (`JOBS` overrides this), with its own
`build-pi5-deb` directory. `--configure-only` checks CMake configuration without
compiling. `VERSION` defaults to `0.1.0`; set a new Debian version for each release.
`MINICPM_PI5_PACKAGE_BUILD_DIR` overrides the build/output directory.

This is a **mostly static** Cortex-A76 executable: inference libraries, libstdc++
and libgcc are linked into the binary. glibc, libm and OpenMP remain system
libraries. The packager checks the ELF architecture and dynamic dependency list,
and uses `dpkg-shlibdeps` to derive minimum library versions. A build on Debian 13
is not a promise of Debian 12 compatibility. Build on the oldest supported OS and
test each supported OS before publishing a release. No model weights are bundled.

Install the resulting package with apt so dependencies can be resolved:

```sh
sudo apt install ./build-pi5-deb/packages/minicpm-pi5_0.1.0_arm64.deb
```

The package installs:

- `/usr/lib/minicpm-pi5/llama-server`: executable and embedded inference libraries.
- `/etc/default/minicpm-pi5`: preserved configuration, including model, port,
  context and prompt-cache budget.
- `/usr/lib/systemd/system/minicpm-pi5.service`: a dedicated unprivileged service.
- `/usr/share/doc/minicpm-pi5/SETUP.txt`: download/checksum/start instructions,
  also printed after installation.

First installation creates a no-login `minicpm-pi5` system account and enables
the unit without starting it. Missing/unreadable weights make ExecCondition skip
startup, including after reboot. Defaults expect weights at
`/opt/minicpm-pi5/models/MiniCPM5-2B-Q4_K_M.gguf` and listen on localhost:8080.
The service can read but cannot modify the model directory. The upstream model
URL and SHA256 in SETUP.txt matched the tested model when checked on 2026-11-14.

Upgrades preserve enablement and configuration and do not start, stop or restart
a running server. A running process keeps its old executable until an explicit
restart. Removal stops the service; purge also removes helper enablement state.
Neither removes model files or the system account. This package does not modify
an existing `llama.service`; stop competing inference services before starting it.

## Validation

Run `python3 pi5/debian/test_packaging.py` for unprivileged lifecycle checks with
stubbed account/systemd commands. These exercise first install, upgrade, removal
and purge without changing host accounts or services. They do not replace real
installation tests.

Before publishing a binary release, test on a disposable Pi/OS image:

1. Install without weights: user exists, unit enabled but inactive, start skips.
2. Download/verify weights, start explicitly, check HTTP/cache/cancellation tests.
3. Upgrade while stopped and running: no automatic start or restart; configuration
   and disabled state survive. Restart explicitly to exercise the new executable.
4. Remove and purge: service stops, model and account remain.

Do not install test packages onto the production inference host just to validate
maintainer scripts. The package builder itself is unprivileged and never installs
anything. This repository's lightweight CI tests the packaging scripts, not real
systemd installation or model inference.

### Current validation status (2026-11-14)

The full mostly static build and `.deb` assembly completed on Debian 13 arm64
with GCC 14.2. The package is approximately 11 MiB (about 36 MiB installed).
Its ELF dependencies are only `libgomp.so.1`, `libm.so.6` and `libc.so.6`, with no
RPATH/RUNPATH. Generated package dependencies include `libc6 (>= 2.38)` and
`libgomp1 (>= 4.9)`; this binary therefore does **not** support Debian 12/Bookworm.

Validation passed:

- Shell/Python checks and mocked first-install/upgrade/removal/purge tests.
- Extraction, payload checksums, permissions and configuration registration.
- Extracted server help/version, with no build-directory libraries required.
- Helpers linked against the new static engine archives.
- Direct short integration tests using the tested GGUF: exact logits and cache
  bytes across layouts, state restore, shifting, defragmentation, and cancellation
  recovery. No differences were found in the checked logits.

The first build attempt was stopped for memory pressure; after the existing model
server was stopped, the resumed build completed with two jobs. No service was
installed or started. HTTP tests and `systemd-analyze verify` are blocked by this
session's socket restrictions. Real installation/upgrade/removal and HTTP checks
remain required before publishing this as a validated binary release.

The local artifact and SHA256 sidecar are in `build-pi5-deb/packages/`. To run the
HTTP smoke test from a normal terminal, with other model servers stopped:

```sh
MINICPM_PI5_BUILD_DIR="$PWD/build-pi5-deb" \
  python3 pi5/tests/http_smoke.py --model /path/to/MiniCPM5-2B-Q4_K_M.gguf
```

This starts and stops a temporary server on port 8081; it does not install the
package or modify systemd. After that, use the disposable-image installation
checklist above to validate the actual service lifecycle.
