from typing import Dict, List

def f(d: Dict[str, List[str]]) -> Dict[str, List[str]]:    
    dCopy = d.copy()
    for key, value in dCopy.items():
        for i in range(len(value)):
            value[i] = value[i].upper()
    return dCopy

def check(candidate):
    assert candidate({ 'X': ['x', 'y'] }) == { 'X': ['X', 'Y'] }

def test_check():
    check(f)

test_check()
