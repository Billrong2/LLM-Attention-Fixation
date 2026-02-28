from typing import Dict

def f(d: Dict[int, str]) -> Dict[int, str]:    
    r = {}
    while len(d) > 0:
        r = {**r, **d}
        del d[max(d.keys())]
    return r

def check(candidate):
    assert candidate({ 3: 'A3', 1: 'A1', 2: 'A2' }) == { 3: 'A3', 1: 'A1', 2: 'A2' }

def test_check():
    check(f)

test_check()
