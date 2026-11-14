#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
if [ "${1:-}" = --help ]; then echo 'Usage: pi5/build-tests.sh'; exit 0; fi
[ "$#" -eq 0 ] || { echo 'Usage: pi5/build-tests.sh' >&2; exit 2; }
build=${MINICPM_PI5_BUILD_DIR:-"$repo/build-pi5"}
out=${MINICPM_PI5_TEST_DIR:-"$repo/build-pi5-tests"}
[ -f "$build/src/libllama.so" ] || { echo 'Build the server first.' >&2; exit 1; }
mkdir -p "$out"
for name in integration_test decode_check prefill_check; do
    "${CXX:-c++}" -std=c++20 -O2 -mcpu=cortex-a76 -fopenmp \
        -I"$repo/include" -I"$repo/src" -I"$repo/ggml/include" -I"$repo/ggml/src" \
        "$repo/pi5/tests/$name.cpp" \
        -L"$build/src" -L"$build/ggml/src" \
        -Wl,-rpath,"$build/src" -Wl,-rpath,"$build/ggml/src" \
        -lllama -lggml -o "$out/$name"
done
printf 'Test executables: %s\n' "$out"
