#!/usr/bin/env bash
set -euo pipefail

cd /people/cs/x/xxr230000/eyetracking

# Step-4 / L3 sweep:
# (cap=2, alpha=0.05)  -> lambda_max = 1.10
# (cap=2, alpha=0.10)  -> lambda_max = 1.20
# (cap=4, alpha=0.025) -> lambda_max = 1.10
# (cap=4, alpha=0.05)  -> lambda_max = 1.20
TAG_PREFIX="$(date +%Y%m%d-%H%M%S)-step4-l3"

PRIORS=(ast cfg slice)
CAPS=(2 2 4 4)
LMAXS=(1.10 1.20 1.10 1.20)
ALPHAS=(0.05 0.10 0.025 0.05)

for PRIOR in "${PRIORS[@]}"; do
  for IDX in "${!CAPS[@]}"; do
    CAP="${CAPS[$IDX]}"
    LMAX="${LMAXS[$IDX]}"
    ALPHA="${ALPHAS[$IDX]}"
    TAG_CAP=${CAP/./p}
    TAG_LMAX=${LMAX/./p}
    TAG_ALPHA=${ALPHA/./p}

    python -u main.py \
      --level3 \
      --prior="${PRIOR}" \
      --n-bins=12 \
      --gpu-ids=0+1+2+3 \
      --runs-per-snippet=50 \
      --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
      --record-layers=off \
      --residual-scale=on \
      --residual-scale-mode=agreement_gate \
      --lambda-mlp=1.0 \
      --lambda-attn-alpha="${ALPHA}" \
      --lambda-attn-cap="${CAP}" \
      --agreement-scope=all_heads \
      --run-tag="${TAG_PREFIX}-${PRIOR}-cap${TAG_CAP}-lmax${TAG_LMAX}-a${TAG_ALPHA}"
  done
done
