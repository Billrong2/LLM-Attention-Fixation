#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

TAG_PREFIX="$(date +%Y%m%d-%H%M%S)-step2-l2-slice"
for B in 0.1 0.3 0.5 1.0; do
  TAG_B=${B/./p}
  python -u main.py \
    --level2 \
    --prior=slice \
    --beta-bias="$B" \
    --n-bins=12 \
    --gpu-ids=3 \
    --runs-per-snippet=50 \
    --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
    --record-layers=off \
    --run-tag="${TAG_PREFIX}-b${TAG_B}"
done
