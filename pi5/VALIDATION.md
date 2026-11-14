# Validation guide

Stop other model processes first; a 4 GB Pi cannot reliably host multiple copies
alongside cache-heavy tests. These tools never stop or start system services.
The server should be built from this repository with `pi5/build.sh`.

Build helpers with `pi5/build-tests.sh`. Outputs default to `build-pi5-tests/`;
MINICPM_PI5_TEST_DIR overrides that directory. Both shared-library and static
engine builds are supported; set MINICPM_PI5_BUILD_DIR to `build-pi5-deb` to test
the package build. For meaningful timings export:

```sh
export OMP_PROC_BIND=close OMP_PLACES=cores OMP_WAIT_POLICY=PASSIVE
```

- `integration_test MODEL short`: real prefill, bidirectional layout/state
  restore, shift, defragmentation and interrupted-operation recovery.
- `integration_test MODEL`: adds 4K/8K worker-boundary cancellation cases and
  synthetic 24K canonical/in-memory state restore. It creates a unique temporary
  ~1 GiB file under `$TMPDIR` (default `/tmp`), removed on normal completion.
  A failed/aborted process can leave that file behind. Capacity results can page
  heavily and are not suitable as performance benchmarks.
- `decode_check MODEL [PREFIX ...]`: default 8192, or e.g. 1024 8192 15360. Three
  alternating 16-token repetitions per mode, synthetic prefix, exact logit checks,
  CSV timings and major-fault counts. Both modes share the current library.
- `prefill_check MODEL [PREFIX BATCH]`: defaults 8192 128; three timed repeats
  after warmup with repeat-logit consistency. Prefix 0 measures a real empty-cache
  prefill; other prefixes seed deterministic synthetic KV. Timing excludes seeding
  and checks. No natural-language throughput claim follows from synthetic prefixes.
- `python3 pi5/tests/http_smoke.py --model MODEL`: starts a temporary loopback
  server on 8081 with the 24K/1GiB preset, checks chat/completion, live versus saved
  replay, and recovery after closing a streaming request. The server is stopped
  on completion. `--port` changes its port; `--output` changes the results folder.
  Default results are in ignored `build-pi5-tests/http/`. `--full` additionally
  prefills and restores a real 24,500-token prompt. Allow 20–30 minutes.

The HTTP runner explicitly suppresses EOS for its completion probes so they
perform actual decoding. It compares saved restore with a live one-token replay
reference; cold batched prefill is not an equivalent numerical baseline. This
behavior is explained in DESIGN.md. The test uses a single slot and deterministic
sampling. Request counts, timings and output assertions are distinct from a
sustained generation benchmark.

Existing deployment evidence covers the engine source copied into this fork.
Publication packaging validation is recorded in PUBLICATION_CHECKS.md. Lightweight
CI checks packaging syntax/help only; it does not substitute for Pi/model tests.
