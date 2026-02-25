# Quickstart: What You Generate

`./explore.sh` does two things:

1. Builds `build/basic` via CMake.
2. Overwrites a set of text dumps under `learning/outputs/` using `file`, `strings`, `xxd`, `readelf`, and `objdump`.

The point is to take a tiny program (`src/basic.c`) and connect it to what the resulting ELF looks like:

- where your code lives (`.text`)
- where constants live (`.rodata`)
- how globals show up (`.data` and the symbol table)
- what dynamic linking adds (PLT/GOT, relocations, NEEDED libs)

Suggested "find it in the dumps" exercises:

- Find your `main` and `add` functions in `readelf-s.txt` and `objdump-d.txt`.
- Find your `printf` call path in `objdump-d.txt` (look for `printf@plt`).
- Find the `%d` format string bytes in `readelf-x-.rodata.txt`.
- Find the `POTATO` global in `readelf-s.txt` and see how it is referenced in `objdump-d.txt`.

Optional extra:

- Open `objdump-x.txt` for a single-file summary view, then cross-check one dynamic/relocation detail in `readelf-d.txt` or `readelf-r.txt`.
