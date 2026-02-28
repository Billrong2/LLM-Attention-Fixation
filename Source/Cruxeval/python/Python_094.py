from typing import Dict

def f(a: Dict[str, int], b: Dict[str, int]) -> Dict[str, int]:    
    return {**a, **b}

def check(candidate):
    assert candidate({ 'w': 5, 'wi': 10 }, { 'w': 3 }) == { 'w': 3, 'wi': 10 }

def test_check():
    check(f)

test_check()
