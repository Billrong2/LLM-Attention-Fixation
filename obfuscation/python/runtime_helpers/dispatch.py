from __future__ import annotations

HELPER = """
def _obf_dispatch_call(table, key, *args, **kwargs):
    return table[key](*args, **kwargs)
""".strip()
