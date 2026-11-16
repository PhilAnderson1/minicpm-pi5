# Clean package build validation — 2026-11-16

The integrated source was built from scratch with `pi5/build-deb.sh`,
`VERSION=0.1.1~rc2`, `JOBS=2` and a new build directory. No objects from the
isolated candidate were reused.

- Full engine integration passed, including prefill cancellation recovery,
  context maintenance and 24K file/in-memory cache restoration.
- Independent production references matched final prefill logits, new KV bytes
  and four continuation decode vectors bitwise for prefix/batch 0/64,
  16384/128, 16384/512 and 16384/65 (fallback).
- The generated value key loop retains 64 vector FMAs with no stack accesses.
- Package extraction, executable help and mocked install/upgrade/removal/purge
  checks passed. The package's executable matches the stripped clean build.
- Dynamic dependencies remain libgomp.so.1, libm.so.6 and libc.so.6. The package
  requires libc6 >= 2.38.

The cache-capacity stress test used swap; this is correctness validation, not a
new throughput comparison. The isolated candidate passed full 24K HTTP testing;
the rebuilt package also passed HTTP smoke testing from the user's terminal,
including chat, 1,024-token prefill, live replay, saved prompt restoration and
stream cancellation recovery. The recorded executable hash matches the packaged
binary and the server exited with status 0. The long 24K HTTP test was not
repeated for this rebuilt package. Nothing was installed or published during
this validation.

Package: `minicpm-pi5_0.1.1~rc2_arm64.deb` (11,501,120 bytes).
SHA256: `1a8ced7744c9d42b9c9786812b3f27c93fd12edd2a607d936eca300122a29913`.
