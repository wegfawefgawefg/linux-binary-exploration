# Explain

These notes map each captured output in `learning/outputs/` to "what it is" and "what to look for".

Workflow:

```bash
./explore.sh
```

That produces:

- `learning/outputs/file.txt`
- `learning/outputs/strings.txt`
- `learning/outputs/xxd.txt`
- `learning/outputs/readelf-*.txt`
- `learning/outputs/objdump-*.txt`

Reading order (recommended):

1. `00-quickstart.md`
2. `01-file.md`
3. `05-readelf-S.md`
4. `06-readelf-s.md`
5. `09-objdump-d.md`

Each output file begins with the exact command used to generate it.

Optional after core path:

- `11-objdump-x.md` as a one-page "all-in-one summary view" reference.
- `objdump -t` cross-check notes are included inside `06-readelf-s.md`.
