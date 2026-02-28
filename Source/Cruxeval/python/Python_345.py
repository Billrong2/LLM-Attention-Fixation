from typing import Tuple

def f(a: str, b: str) -> Tuple[str, str]:    
    if a < b:
        return (b, a)
    return (a, b)

def check(candidate):
    assert candidate('ml', 'mv') == ('mv', 'ml')

def test_check():
    check(f)

test_check()
