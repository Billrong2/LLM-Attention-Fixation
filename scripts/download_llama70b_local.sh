#!/usr/bin/env bash
set -euo pipefail

# Default target for this project.
MODEL_ID="${MODEL_ID:-codellama/CodeLlama-70b-Instruct-hf}"
LOCAL_DIR="${LOCAL_DIR:-/data/xxr230000/model_cache/codellama_70b}"
MAX_WORKERS="${MAX_WORKERS:-8}"
TOKEN="${HF_TOKEN:-${HUGGINGFACE_TOKEN:-}}"

usage() {
  cat <<'EOF'
Download a 70B Llama-family checkpoint locally via Hugging Face Hub.

Usage:
  bash scripts/download_llama70b_local.sh [options]

Options:
  --model-id <repo>      HF model repo id.
                         Default: codellama/CodeLlama-70b-Instruct-hf
  --local-dir <path>     Local output directory.
                         Default: /data/xxr230000/model_cache/codellama_70b
  --max-workers <n>      Parallel download workers (default: 8)
  --token <token>        HF token (or use HF_TOKEN / HUGGINGFACE_TOKEN env vars)
  -h, --help             Show help

Examples:
  bash scripts/download_llama70b_local.sh
  bash scripts/download_llama70b_local.sh --model-id meta-llama/Llama-2-70b-hf --local-dir /data/xxr230000/model_cache/llama2_70b
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model-id)
      MODEL_ID="$2"
      shift 2
      ;;
    --local-dir)
      LOCAL_DIR="$2"
      shift 2
      ;;
    --max-workers)
      MAX_WORKERS="$2"
      shift 2
      ;;
    --token)
      TOKEN="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if ! command -v python >/dev/null 2>&1; then
  echo "python is not available in PATH." >&2
  exit 1
fi

if ! python - <<'PY' >/dev/null 2>&1
import importlib.util
import sys
sys.exit(0 if importlib.util.find_spec("huggingface_hub") else 1)
PY
then
  echo "huggingface_hub is not installed in this environment." >&2
  echo "Install it with: pip install -U huggingface_hub" >&2
  exit 1
fi

mkdir -p "$LOCAL_DIR"

echo "Model     : $MODEL_ID"
echo "Local dir : $LOCAL_DIR"
echo "Workers   : $MAX_WORKERS"
echo "Starting download..."

python - "$MODEL_ID" "$LOCAL_DIR" "$MAX_WORKERS" "$TOKEN" <<'PY'
import sys
from huggingface_hub import HfApi, snapshot_download

model_id = sys.argv[1]
local_dir = sys.argv[2]
max_workers = int(sys.argv[3])
token = sys.argv[4] or None

if token is None:
    try:
        HfApi().whoami()
    except Exception:
        raise SystemExit(
            "Not authenticated to Hugging Face. "
            "Run `huggingface-cli login` or pass --token / HF_TOKEN."
        )

kwargs = {
    "repo_id": model_id,
    "repo_type": "model",
    "local_dir": local_dir,
    "token": token,
    "max_workers": max_workers,
}

try:
    path = snapshot_download(local_dir_use_symlinks=False, **kwargs)
except TypeError:
    # For huggingface_hub versions where local_dir_use_symlinks is removed.
    path = snapshot_download(**kwargs)

print(f"Download complete: {path}")
PY

