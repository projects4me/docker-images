#!/usr/bin/env bash
# Build the Gaia runtime images locally: gaia-env:current and gaia-env:next.
# Usage: gaia/env/build.sh [current|next|all]   (default: all)
# The build args come from <stack>.args, the same files the publish workflow reads.
set -euo pipefail
cd "$(dirname "$0")"

build() {
    local stack=$1 line
    local args=()
    while IFS= read -r line || [ -n "$line" ]; do
        line=${line%$'\r'}
        case "$line" in ''|'#'*) continue ;; esac
        args+=(--build-arg "$line")
    done < "$stack.args"
    docker build -t "gaia-env:$stack" "${args[@]}" .
}

case "${1:-all}" in
    current|next) build "$1" ;;
    all) build current; build next ;;
    *) echo "usage: $0 [current|next|all]" >&2; exit 2 ;;
esac
