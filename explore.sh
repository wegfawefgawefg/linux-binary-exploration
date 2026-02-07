#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./explore.sh [--no-build] [--bin PATH] [--out DIR]

Builds the project (unless --no-build), then runs common ELF inspection tools
against the target binary and writes the outputs to a directory.

Defaults:
  --bin build/basic
  --out learning/outputs
EOF
}

no_build=0
bin_path=""
out_dir=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-build) no_build=1; shift ;;
    --bin) bin_path="${2:-}"; shift 2 ;;
    --out) out_dir="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "$bin_path" ]]; then
  bin_path="$repo_root/build/basic"
else
  case "$bin_path" in
    /*) : ;;
    *) bin_path="$repo_root/$bin_path" ;;
  esac
fi

if [[ -z "$out_dir" ]]; then
  out_dir="$repo_root/learning/outputs"
else
  case "$out_dir" in
    /*) : ;;
    *) out_dir="$repo_root/$out_dir" ;;
  esac
fi

if [[ "$no_build" -eq 0 ]]; then
  cmake -S "$repo_root" -B "$repo_root/build" >/dev/null
  cmake --build "$repo_root/build" >/dev/null
fi

if [[ ! -f "$bin_path" ]]; then
  echo "Binary not found: $bin_path" >&2
  echo "Try running without --no-build (or check your --bin path)." >&2
  exit 1
fi

mkdir -p "$out_dir"

commands=(
  "strings \"$bin_path\""
  "file \"$bin_path\""
  "xxd \"$bin_path\""
  "readelf -d \"$bin_path\""
  "readelf -h \"$bin_path\""
  "readelf -S \"$bin_path\""
  "readelf -s \"$bin_path\""
  "readelf -r \"$bin_path\""
  "readelf -x .rodata \"$bin_path\""
  "objdump -d \"$bin_path\""
  "objdump -t \"$bin_path\""
  "objdump -x \"$bin_path\""
)

for cmd in "${commands[@]}"; do
  # Keep filenames stable and readable.
  # Example: "readelf -x .rodata ..." -> "readelf-x-.rodata.txt"
  name="$(printf '%s' "$cmd" | sed -E 's/["\\]//g; s/[[:space:]]+/_/g; s/[^[:alnum:]_.-]+/_/g')"
  name="${name%%_*}"-"${name#*_}" 2>/dev/null || true
  out_file="$out_dir/${name}.txt"

  {
    echo "output of command: $cmd"
    echo "---------------------------------------"
    echo
    eval "$cmd"
    echo
    echo "---------------------------------------"
  } >"$out_file"
done

echo "Wrote outputs to: $out_dir"

