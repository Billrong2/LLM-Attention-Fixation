#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

# Force artifacts under:
# /data/xxr230000/eyetracking/results/...
export EYETRACKING_DATA_ROOT="/data/xxr230000/eyetracking/results"

MODEL_NAME="${MODEL_NAME:-Qwen/Qwen2.5-Coder-7B-Instruct}"
DATASET="${DATASET:-eyetracking}"
GPU_IDS="${GPU_IDS:-0+1}"
RUNS_PER_SNIPPET="${RUNS_PER_SNIPPET:-50}"
DIFFICULTY="${DIFFICULTY:-easy}"
RUN_TAG="${RUN_TAG:-obf-smoke-slice-l2-$(date +%Y%m%d-%H%M%S)-pid$$}"

# max-new-tokens intentionally omitted here to use obfuscation/main.py default (1024).
python3 -u obfuscation/main.py \
  --dataset "${DATASET}" \
  --model-name "${MODEL_NAME}" \
  --gpu-ids "${GPU_IDS}" \
  --difficulty "${DIFFICULTY}" \
  --runs-per-snippet "${RUNS_PER_SNIPPET}" \
  --record-layers off \
  --level2 \
  --prior slice \
  --beta-post 0.8 \
  --n-bins 12 \
  --steer-last-n-layers 4 \
  --head-subset-mode auto \
  --head-mask-apply-to l2 \
  --head-subset-topk-per-layer 8 \
  --run-tag "${RUN_TAG}" \
  "$@"
