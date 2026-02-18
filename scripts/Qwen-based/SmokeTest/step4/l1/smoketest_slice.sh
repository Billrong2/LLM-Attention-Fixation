#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

TAG_PREFIX="$(date +%Y%m%d-%H%M%S)-step4-l1-slice"
for B in 0.1 0.3 0.5 1.0; do
  TAG_B=${B/./p}
  python -u main.py \
    --level1 \
    --prior=slice \
    --beta-bias="$B" \
    --n-bins=12 \
    --gpu-ids=3 \
    --runs-per-snippet=50 \
    --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
    --record-layers=off \
    --head-subset-mode=auto \
    --head-mask-apply-to=both \
    --head-subset-topk-per-layer=4 \
    --head-subset-calib-runs=1 \
    --head-subset-calib-max-new-tokens=1 \
    --head-subset-calib-first-decode-only=on \
    --head-subset-auto-save="steering/head_masks/step4-l1-slice-b${TAG_B}-{snippet}-{ts}.json" \
    --run-tag="${TAG_PREFIX}-b${TAG_B}"
done
