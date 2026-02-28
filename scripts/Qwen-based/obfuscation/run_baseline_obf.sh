#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

DATASET="${DATASET:-eyetracking}"

python3 -u obfuscation/main.py \
  --dataset "${DATASET}" \
  --model-name Qwen/Qwen2.5-Coder-7B-Instruct \
  --gpu-ids 0+1+2+3 \
  --runs-per-snippet 50 \
  --record-layers on \
  --auto-run-tag
