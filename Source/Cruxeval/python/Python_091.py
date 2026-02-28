from typing import List

def f(s: str) -> List[str]:    
    d = dict.fromkeys(s, 0)
    return list(d.keys())

def check(candidate):
    assert candidate('12ab23xy') == ['1', '2', 'a', 'b', '3', 'x', 'y']

def test_check():
    check(f)

test_check()
