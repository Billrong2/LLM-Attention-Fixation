from __future__ import annotations

HELPER = """
def _obf_const_decode_b64(s):
    import base64
    return base64.b64decode(s.encode("ascii")).decode("utf-8")


def _obf_const_decode_int(v, key):
    return v ^ key
""".strip()
