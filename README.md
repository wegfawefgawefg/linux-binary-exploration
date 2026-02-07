# linux-binary-exploration

Tiny C executable + notes/scripts for learning how Linux ELF binaries look on disk.

## What This Repo Contains

- `src/basic.c`: a small C program meant to be easy to inspect (symbols, rodata, disassembly, relocations, etc).
- `CMakeLists.txt`: builds `basic` into `build/basic`.
- `learning/k.sh`: runs a handful of common inspection commands against `build/basic` and writes the results to `learning/outputs/`.

## Build

```bash
cmake -S . -B build
cmake --build build
```

The output binary will be `build/basic`.

## Run The Binary

```bash
./build/basic
```

## Explore The Binary (What I Ran)

`./explore.sh` is a convenience wrapper that:

- builds `build/basic` (via CMake)
- runs common inspection commands
- captures outputs under `learning/outputs/`

It captures the output of:

- `strings`
- `file`
- `xxd`
- `readelf -d -h -S -s -r -x .rodata`
- `objdump -d -t -x`

Run it from the repo root:

```bash
./explore.sh
```

Outputs are written under `learning/outputs/` and overwritten each run.

`learning/k.sh` is kept as a deprecated wrapper for backwards compatibility.

## Notes

- `learndump2.txt` is a scratchpad of relevant commands/options.
