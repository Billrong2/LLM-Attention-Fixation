# Obfuscation Agent Notes

## Invariants
- Preserve runtime behavior in safe profile: exact `stdout`, exact `stderr`, exact exit code.
- Deterministic output for same input + seed + config.
- Skip unsafe candidates instead of forcing transforms.

## Adding a Pass
1. Add new pass under `python/passes` and/or `java/passes`.
2. Register in `__init__.py` `all_passes()`.
3. Add pass config defaults in profile YAMLs.
4. Add unit/integration tests.

## Skip Diagnostics
- Every skipped or rolled-back pass should emit a reason in metadata.
- Budget breaches must result in deterministic fallback or skip.

## Core Commands
- `python -m eyetracking.obfuscation.tools.obfuscate_cli run ...`
- `python -m eyetracking.obfuscation.tools.obfuscate_cli equiv ...`
- `python -m eyetracking.obfuscation.tools.obfuscate_cli dataset ...`
