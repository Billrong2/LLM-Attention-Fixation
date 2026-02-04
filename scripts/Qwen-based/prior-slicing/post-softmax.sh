python -u main.py \
  --level2 \
  --gpu-ids=0 \
  --prior=slice \
  --beta-post=0.8 \
  --n-bins=12 \
  --runs-per-snippet=200 \
  --model-name=Qwen/Qwen2.5-Coder-7B-Instruct \
  --record-layers=off \
  --auto-run-tag