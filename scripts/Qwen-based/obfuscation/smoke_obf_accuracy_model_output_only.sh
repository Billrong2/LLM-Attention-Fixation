#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

# Force artifacts under:
# /data/xxr230000/eyetracking/results/...
export EYETRACKING_DATA_ROOT="/data/xxr230000/eyetracking/results"

MODEL_NAME="${MODEL_NAME:-Qwen/Qwen2.5-Coder-7B-Instruct}"
DATASET="${DATASET:-eyetracking}"
GPU_IDS="${GPU_IDS:-2+3+0+1}"
RUNS_PER_SNIPPET="${RUNS_PER_SNIPPET:-25}"
DIFFICULTY="${DIFFICULTY:-easy}"
MAX_NEW_TOKENS="${MAX_NEW_TOKENS:-256}"
RUN_TAG="${RUN_TAG:-obf-smoke-norec-$(date +%Y%m%d-%H%M%S)-pid$$}"

python3 -u obfuscation/main.py \
  --dataset "${DATASET}" \
  --model-name "${MODEL_NAME}" \
  --gpu-ids "${GPU_IDS}" \
  --difficulty "${DIFFICULTY}" \
  --runs-per-snippet "${RUNS_PER_SNIPPET}" \
  --max-new-tokens "${MAX_NEW_TOKENS}" \
  --record-layers off \
  --run-tag "${RUN_TAG}" \
  "$@"
