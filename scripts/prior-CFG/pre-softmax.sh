python main.py \
 --level1 \
 --prior=cfg \
 --gpu-ids=3 \
 --model-name=codellama/CodeLlama-7b-Instruct-hf \
 --runs-per-snippet=200 \
 --beta-bias=0.8 \
 --n-bins=12 \
 --record-layers=off \
 --auto-run-tag