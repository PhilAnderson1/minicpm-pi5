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

CMake configuration, shell/Python checks, mocked lifecycle tests, and a complete
package assembly/extraction test using a temporary AArch64 probe executable passed.
The archive test checked dependency generation and conffile registration.
The full server build was stopped when available RAM fell to about 100 MiB with
all 2 GiB of swap occupied. Resume `./pi5/build-deb.sh` after freeing memory;
completed compilation units are retained. No release server package has yet been
validated. `systemd-analyze verify` was blocked by this session's sandbox, and
real installation/upgrade/removal and inference tests remain outstanding.
