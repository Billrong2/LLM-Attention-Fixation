from typing import List, Tuple

def f(parts: List[Tuple[str, int]]) -> List[int]:    
    return list(dict(parts).values())

def check(candidate):
    assert candidate([('u', 1), ('s', 7), ('u', -5)]) == [-5, 7]

def test_check():
    check(f)

test_check()
