import sys
from pathlib import Path

import javalang

sys.path.append(str(Path(__file__).resolve().parents[2]))
from steering.priors import SlicingPrior, PriorContext  # noqa: E402


def main():
    source_path = Path("Source/eyetracking/Ackerman.java")  # change as needed
    code = source_path.read_text()

    tokens = list(javalang.tokenizer.tokenize(code))
    tree = javalang.parse.parse(code)

    prompt_tokens = [t.value for t in tokens]
    ctx = PriorContext(prompt_tokens=prompt_tokens, code_text=code, vocab_tokens=[])
    prior = SlicingPrior(ctx)

    mapped_vec = prior.vector(0, 1)

    print("SlicingPrior: algorithm-only, intra-procedural, return-only sinks.")
    print(f"{'Idx':<4} {'Token':<20} {'Weight':<8}")
    print("-" * 40)
    for i, tok in enumerate(prompt_tokens):
        w = mapped_vec[i]
        if w > 1e-6:
            print(f"{i:<4} {tok:<20} {w:.4f}")


if __name__ == "__main__":
    main()
