import javalang
from pathlib import Path
import sys

sys.path.append(str(Path(__file__).resolve().parents[2]))
from steering.priors import ASTPrior, PriorContext

source_path = Path("Source/Ackerman.java")  # change as needed
code = source_path.read_text()

# Tokenize and parse
tokens = list(javalang.tokenizer.tokenize(code))
tree = javalang.parse.parse(code)

# Build context and prior
prompt_tokens = [t.value for t in tokens]  # crude prompt tokens for inspection
ctx = PriorContext(prompt_tokens=prompt_tokens, code_text=code, vocab_tokens=[])
prior = ASTPrior(ctx)

# Reuse ASTPrior internals to collect scores and node types
pos_map = prior._position_index(tokens)
scores = {}
sources = {}  # token_idx -> list of contributing node types
for path, node in tree:
    ntype = type(node).__name__
    weight = (
        prior.tier_weights["tier1"] 
        if ntype in prior.node_names['tier 1']        
        else prior.tier_weights["tier2"] 
        if ntype in prior.node_names['tier 2'] 
        else prior.tier_weights["tier3"] 
        if ntype in prior.node_names["tier 3"] 
        else 0.0
    )
    pos = getattr(node, "position", None)
    if weight and pos and pos in pos_map:
        idx = pos_map[pos]
        scores[idx] = scores.get(idx, 0.0) + weight
        sources.setdefault(idx, []).append(ntype)

print(f"{'Token':<20} {'AST node(s)':<40} {'Weight'}")
print("-" * 80)
for i, tok in enumerate(tokens):
    w = scores.get(i, 0.0)
    if w:
        kinds = ",".join(sorted(set(sources.get(i, []))))
        print(f"{tok.value:<20} {kinds:<40} {w}")
