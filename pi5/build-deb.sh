#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
if [ "${1:-}" = --help ]; then
    echo 'Usage: pi5/build-deb.sh [--configure-only]'
    echo 'Builds a mostly static arm64 package. JOBS defaults to 1.'
    echo 'MINICPM_PI5_PACKAGE_BUILD_DIR and VERSION override defaults.'
    exit 0
fi
[ "$#" -eq 0 ] || { [ "$#" -eq 1 ] && [ "$1" = --configure-only ]; } || exit 2
[ "$(dpkg --print-architecture)" = arm64 ] || { echo 'Requires an arm64 build host.' >&2; exit 1; }
build=${MINICPM_PI5_PACKAGE_BUILD_DIR:-"$repo/build-pi5-deb"}
cmake -S "$repo" -B "$build" -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF -DGGML_STATIC=OFF -DGGML_NATIVE=OFF -DGGML_OPENMP=ON \
    -DCMAKE_C_FLAGS=-mcpu=cortex-a76 -DCMAKE_CXX_FLAGS=-mcpu=cortex-a76 \
    '-DCMAKE_EXE_LINKER_FLAGS=-static-libstdc++ -static-libgcc' \
    -DGGML_IQK_MUL_MAT=ON -DGGML_IQK_FLASH_ATTENTION=ON -DGGML_IQK_FA_ALL_QUANTS=ON \
    -DLLAMA_BUILD_TESTS=OFF -DLLAMA_BUILD_SERVER=ON -DLLAMA_BUILD_EXAMPLES=ON -DLLAMA_CURL=OFF
[ "${1:-}" != --configure-only ] || exit 0
cmake --build "$build" --target llama-server -j "${JOBS:-1}"
python3 "$repo/pi5/debian/package.py" "$build/bin/llama-server" "${VERSION:-0.1.0}" "$build/packages"
