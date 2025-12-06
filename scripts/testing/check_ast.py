import sys
from pathlib import Path

import javalang

sys.path.append(str(Path(__file__).resolve().parents[2]))
from steering.priors import ASTPrior, PriorContext  # noqa: E402


def main():
    source_path = Path("Source/Ackerman.java")  # change as needed
    code = source_path.read_text()


    tokens = list(javalang.tokenizer.tokenize(code))
    tree = javalang.parse.parse(code)


    prompt_tokens = [t.value for t in tokens]  # crude prompt tokens for inspection
    ctx = PriorContext(prompt_tokens=prompt_tokens, code_text=code, vocab_tokens=[])
    prior = ASTPrior(ctx)

    # Original ASTPrior logic, customized _collect_scores() API
    raw_scores = prior._collect_scores(tree, tokens, javalang)  # token_idx -> weight
    mapped_vec = prior._map_scores_to_prompt(raw_scores, tokens, prompt_tokens)

    print(f"{'Idx':<4} {'Token':<20} {'Weight':<8}")
    print("-" * 40)
    for i, tok in enumerate(prompt_tokens):
        w = mapped_vec[i]
        if w > 0:
            print(f"{i:<4} {tok:<20} {w:.2f}")


if __name__ == "__main__":
    main()
