# Known Limitations

- Python typeflow is conservative; T4 skips many dynamic expressions.
- Java rewriting is conservative text/AST-hybrid with `javalang` validation and may skip complex methods.
- Control-flow flattening (T6) only targets bounded safe subsets.
- Inter-procedural reshaping (T7) is intentionally limited to semantics-safe patterns.
