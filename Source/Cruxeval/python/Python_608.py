from typing import Dict, Any

def f(aDict: Dict[int, int]) -> Dict[int, int]:    
    # transpose the keys and values into a new dict
    return dict([v for v in aDict.items()])

def check(candidate):
    assert candidate({ 1: 1, 2: 2, 3: 3 }) == { 1: 1, 2: 2, 3: 3 }

def test_check():
    check(f)

test_check()
