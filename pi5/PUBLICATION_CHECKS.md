# Publication checks

Checked on the target Raspberry Pi 5 on 2026-11-14.

- All 20 changed engine files are byte-identical to the deployed, tested source.
- The portable CMake preset configured successfully on AArch64.
- All three C++ validation helpers compiled against the existing tested engine
  libraries, using headers from this checkout; their help commands passed.
- Shell syntax, script help commands, Python compilation and HTTP runner help
  passed. A fake server verified launcher argument quoting (including paths with
  spaces), port selection and OpenMP environment settings without loading a model.
- Publication files were checked for private paths, credential patterns, unwanted
  large artifacts and whitespace errors before committing.

A full clean engine build from this publication checkout has not been performed.
Model inference and HTTP checks were not rerun during packaging; the earlier
engine validation and its limits are described in PERFORMANCE.md and DESIGN.md.
The deployed worktree and system service were not changed. No repository was
uploaded to GitHub during preparation.
