#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

BETA="1.0"
TAG_B=${BETA/./p}
TAG_PREFIX="$(date +%Y%m%d-%H%M%S)-step4_topk-l2-cfg-b${TAG_B}"
for K in 4 8 12 16 28; do
  python -u main.py \
    --level2 \
    --prior=cfg \
    --beta-bias="${BETA}" \
    --n-bins=12 \
    --runs-per-snippet=50 \
    --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
    --record-layers=off \
    --head-subset-mode=auto \
    --head-mask-apply-to=both \
    --head-subset-topk-per-layer=${K} \
    --head-subset-calib-runs=1 \
    --head-subset-calib-max-new-tokens=1 \
    --head-subset-calib-first-decode-only=on \
    --head-subset-auto-save="steering/head_masks/step4_topk-l2-cfg-b${TAG_B}-k${K}-{snippet}-{ts}.json" \
    --run-tag="${TAG_PREFIX}-k${K}"
done
