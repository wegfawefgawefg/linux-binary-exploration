# linux-binary-exploration

Tiny C executable + notes/scripts for learning how Linux ELF binaries look on disk.

## Screenshot

![Screenshot](screenshot.jpg)

## What This Repo Contains

- `src/basic.c`: a small C program meant to be easy to inspect (symbols, rodata, disassembly, relocations, etc).
- `CMakeLists.txt`: builds `basic` into `build/basic`.
- `explore.sh`: builds the binary and captures common inspection command output into `learning/outputs/`.
- `explain/`: short walkthroughs for what each output file means and what to look for.

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

## Notes

- `learndump2.txt` is a scratchpad of relevant commands/options.
