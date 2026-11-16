# Clean package build validation — 2026-11-16

The integrated source was built from scratch using `pi5/build-deb.sh`, with
`VERSION=0.1.1~rc1`, `JOBS=2` and a new build directory. No candidate objects
were reused. The mostly static ARM64 package was assembled successfully.

- Full engine integration passed, including retained-prefix prefill cancellation,
  context maintenance and exact 24K file/in-memory cache restoration.
- Independent production reference checks passed bitwise for final prefill
  logits, new KV bytes and four subsequent decode logit vectors: prefix/batch
  0/64, 16384/128, 16384/512 and 16384/65 (fallback).
- Package extraction and executable help passed. The packaged executable
  matches the stripped clean-build executable byte for byte.
- Mocked first-install, upgrade, removal and purge checks passed.
- Dynamic dependencies: libgomp.so.1, libm.so.6 and libc.so.6.
  The generated package requires libc6 >= 2.38.

The cache-capacity stress test used swap; these checks are correctness evidence,
not fresh performance measurements. The rebuilt package's HTTP smoke test passed from the user's terminal: chat,
1,024-token prefill, live replay, saved prompt restoration and stream cancellation
recovery. The recorded executable hash matches the packaged binary, and the
test server exited with status 0. The earlier full 24,500-token HTTP pass applies
to the candidate build; that long HTTP test was not repeated for this new binary.
The user subsequently installed this package and reported that the service runs
correctly. No release has been published.

Package: `minicpm-pi5_0.1.1~rc1_arm64.deb` (11,502,556 bytes).
SHA256: `2d9b8863b6da77129e87bbc2a8aac5a4d1d94cec71ce0dcba7fdbb370a5d8d52`.
