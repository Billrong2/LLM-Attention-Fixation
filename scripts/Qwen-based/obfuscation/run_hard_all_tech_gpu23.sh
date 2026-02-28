#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

# Force artifacts under:
# /data/xxr230000/eyetracking/results/...
export EYETRACKING_DATA_ROOT="/data/xxr230000/eyetracking/results"

MODEL_NAME="${MODEL_NAME:-Qwen/Qwen2.5-Coder-7B-Instruct}"
DATASET="${DATASET:-eyetracking}"
RUNS_PER_SNIPPET="${RUNS_PER_SNIPPET:-50}"
RUN_TAG="${RUN_TAG:-obf-hard-$(date +%Y%m%d-%H%M%S)-pid$$}"

python3 -u obfuscation/main.py \
  --dataset "${DATASET}" \
  --model-name "${MODEL_NAME}" \
  --gpu-ids 2+3 \
  --difficulty hard \
  --runs-per-snippet "${RUNS_PER_SNIPPET}" \
  --record-layers on \
  --run-tag "${RUN_TAG}"
