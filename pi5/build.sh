#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
if [ "${1:-}" = --help ]; then
    echo 'Usage: pi5/build.sh [--configure-only]'
    echo 'MINICPM_PI5_BUILD_DIR overrides build-pi5; JOBS defaults to 2.'
    exit 0
fi
if [ "$#" -gt 1 ] || { [ "$#" -eq 1 ] && [ "$1" != --configure-only ]; }; then
    echo 'Usage: pi5/build.sh [--configure-only]' >&2; exit 2
fi
case $(uname -m) in aarch64|arm64) ;; *) echo 'This build preset requires 64-bit ARM Linux.' >&2; exit 1;; esac
build=${MINICPM_PI5_BUILD_DIR:-"$repo/build-pi5"}
cmake -S "$repo" -B "$build" \
    -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=ON -DGGML_OPENMP=ON \
    -DGGML_IQK_MUL_MAT=ON -DGGML_IQK_FLASH_ATTENTION=ON -DGGML_IQK_FA_ALL_QUANTS=ON \
    -DLLAMA_BUILD_TESTS=OFF -DLLAMA_BUILD_SERVER=ON -DLLAMA_BUILD_EXAMPLES=ON \
    -DLLAMA_CURL=OFF -DCMAKE_C_FLAGS=-mcpu=cortex-a76 -DCMAKE_CXX_FLAGS=-mcpu=cortex-a76
if [ "${1:-}" != --configure-only ]; then
    cmake --build "$build" --target llama-server -j "${JOBS:-2}"
fi
