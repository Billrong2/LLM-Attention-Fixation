#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

TAG_PREFIX="$(date +%Y%m%d-%H%M%S)-step4_64-l2-cfg-64head"
for B in 0.1 0.3 0.5 1.0; do
  TAG_B=${B/./p}
  python -u main.py \
    --level2 \
    --prior=cfg \
    --beta-bias="$B" \
    --n-bins=12 \
    --gpu-ids=2 \
    --runs-per-snippet=50 \
    --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
    --record-layers=off \
    --head-subset-mode=auto \
    --head-mask-apply-to=both \
    --steer-last-n-layers=8 \
    --head-subset-topk-per-layer=8 \
    --head-subset-calib-runs=1 \
    --head-subset-calib-max-new-tokens=1 \
    --head-subset-calib-first-decode-only=on \
    --head-subset-auto-save="steering/head_masks/step4_64-l2-cfg-64head-b${TAG_B}-{snippet}-{ts}.json" \
    --run-tag="${TAG_PREFIX}-b${TAG_B}"
done
