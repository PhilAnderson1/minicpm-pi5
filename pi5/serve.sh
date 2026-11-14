#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
if [ "$#" -eq 0 ] || [ "${1:-}" = --help ]; then
    echo 'Usage: pi5/serve.sh MODEL.gguf [additional llama-server arguments]'
    echo 'PORT defaults to 8080; HOST defaults to 127.0.0.1.'
    exit 0
fi
model=$1
shift
[ -r "$model" ] || { echo "Model not readable: $model" >&2; exit 1; }
build=${MINICPM_PI5_BUILD_DIR:-"$repo/build-pi5"}
server=$build/bin/llama-server
[ -x "$server" ] || { echo 'Build first with pi5/build.sh.' >&2; exit 1; }
export OMP_PROC_BIND=close OMP_PLACES=cores OMP_WAIT_POLICY=PASSIVE
exec "$server" -m "$model" --alias MiniCPM5 \
    -ngl 0 -t 2 -tb 4 -c 24576 -np 1 -rtr --pi5-minicpm \
    --jinja --cache-ram 1024 --host "${HOST:-127.0.0.1}" --port "${PORT:-8080}" "$@"
