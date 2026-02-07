#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin_path="$repo_root/build/basic"
out_dir="$repo_root/learning/outputs"

# Always rebuild and always regenerate outputs (overwrite existing).
cmake -S "$repo_root" -B "$repo_root/build" >/dev/null
cmake --build "$repo_root/build" >/dev/null

mkdir -p "$out_dir"
# Keep the output directory deterministic between runs.
rm -f "$out_dir"/*.txt

run() {
  local out_file="$1"
  shift
  local -a cmd=( "$@" )

  {
    printf 'output of command: %q' "${cmd[0]}"
    for ((i=1; i<${#cmd[@]}; i++)); do
      printf ' %q' "${cmd[$i]}"
    done
    printf '\n'
    echo "---------------------------------------"
    echo
    "${cmd[@]}"
    echo
    echo "---------------------------------------"
  } >"$out_file"
}

run "$out_dir/strings.txt" strings "$bin_path"
run "$out_dir/file.txt" file "$bin_path"
run "$out_dir/xxd.txt" xxd "$bin_path"

run "$out_dir/readelf-d.txt" readelf -d "$bin_path"
run "$out_dir/readelf-h.txt" readelf -h "$bin_path"
run "$out_dir/readelf-S.txt" readelf -S "$bin_path"
run "$out_dir/readelf-s.txt" readelf -s "$bin_path"
run "$out_dir/readelf-r.txt" readelf -r "$bin_path"
run "$out_dir/readelf-x-.rodata.txt" readelf -x .rodata "$bin_path"

run "$out_dir/objdump-d.txt" objdump -d "$bin_path"
run "$out_dir/objdump-t.txt" objdump -t "$bin_path"
run "$out_dir/objdump-x.txt" objdump -x "$bin_path"

echo "Wrote outputs to: $out_dir"
