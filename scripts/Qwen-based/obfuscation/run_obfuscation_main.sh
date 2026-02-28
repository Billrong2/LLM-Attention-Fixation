#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

MODEL_NAME="${MODEL_NAME:-Qwen/Qwen2.5-Coder-7B-Instruct}"
DATASET="${DATASET:-eyetracking}"
GPU_IDS="${GPU_IDS:-0+1+2+3}"
RUNS_PER_SNIPPET="${RUNS_PER_SNIPPET:-50}"
RECORD_LAYERS="${RECORD_LAYERS:-on}"

CMD=(
  python3 -u obfuscation/main.py
  --dataset "${DATASET}"
  --model-name "${MODEL_NAME}"
  --runs-per-snippet "${RUNS_PER_SNIPPET}"
  --record-layers "${RECORD_LAYERS}"
  --auto-run-tag
)

if [[ -n "${GPU_IDS}" ]]; then
  CMD+=(--gpu-ids "${GPU_IDS}")
fi

# Forward extra filters/overrides, e.g.:
# --code-snippet BinarySearch --techniques bogus_control_flow --difficulty hard
CMD+=("$@")

echo "[Run] ${CMD[*]}"
"${CMD[@]}"
