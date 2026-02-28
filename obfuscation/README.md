# Deterministic Obfuscation Suite (T1-T8)

This module provides deterministic, semantics-preserving source-to-source obfuscation for Java and Python.

## Safety Defaults
- Default profile: `safe`
- No anti-debug behavior effects
- No packing executable payloads
- No virtualization
- No self-modifying code
- No reflection/exec by default

## Commands
- Single file obfuscation:
```bash
python -m eyetracking.obfuscation.tools.obfuscate_cli run \
  --lang java --input eyetracking/Source/Ackerman.java --output /tmp/Ackerman.obf.java \
  --level level3 --profile safe --seed 1337 --mode level
```

- One-shot equivalence check:
```bash
python -m eyetracking.obfuscation.tools.obfuscate_cli equiv \
  --lang java --input eyetracking/Source/Ackerman.java --level level3 --profile safe
```

- Dataset generation + strict verification:
```bash
python -m eyetracking.obfuscation.tools.obfuscate_cli dataset \
  --lang java --input-dir eyetracking/Source --out-root eyetracking/obfuscation/source \
  --mode both --levels level0,level1,level2,level3,level4,level5 \
  --techniques T1,T2,T3,T4,T5,T6,T7,T8 --difficulties easy,med,hard \
  --seeds 1:1 --strict on --clean on
```

- Output prediction on obfuscated code (reuses eyetracking model pipeline):
```bash
python3 eyetracking/obfuscation/main.py \
  --model-name Qwen/Qwen2.5-Coder-7B-Instruct \
  --gpu-ids 0+1+2+3 \
  --runs-per-snippet 50 \
  --record-layers on \
  --auto-run-tag
```
When `--record-layers on`, the run emits a recorder superset:
1. legacy `model_output.json` attention summaries,
2. `record_layers_full.json.gz` (all layers/heads/steps, all keys),
3. `bdv_features_b1.npz` and `bdv_features_b3.npz`,
4. `bdv_schema.json`.

## Output Layout
- Obfuscation source corpus:
  - `eyetracking/obfuscation/source/java/{snippet}/{technique_name}/{difficulty}/{class}.java`
- Level mode (combined profiles):
  - `eyetracking/obfuscation/source/java/_level_profiles/level{N}/{program}__seed_{S}.java`
- Prediction run outputs:
  - `/data/xxr230000/eyetracking/obfuscation/result/{model}/{snippet}/{technique}/{difficulty}/{run_tag}/{EM|Mismatch}/{run_idx}/`
- Metadata sidecar for each source:
  - `{program}.meta.json`
- Run reports:
  - `eyetracking/obfuscation/reports/verify_*.json`
  - `eyetracking/obfuscation/reports/verify_summary_*.csv`
  - `eyetracking/obfuscation/reports/verify_details_*.csv`

## Reproducibility
The output is deterministic for `(program_id, language, mode, level/technique, profile, seed)`.

## Test
```bash
python -m pytest -q eyetracking/obfuscation/tests
```
