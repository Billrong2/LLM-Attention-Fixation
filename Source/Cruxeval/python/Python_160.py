from typing import Dict, Any

def f(dictionary: Dict[int, int]) -> Dict[int, int]:    
    while not dictionary.get(1, len(dictionary)):
        dictionary.clear()
        break
    return dictionary

def check(candidate):
    assert candidate({ 1: 47698, 1: 32849, 1: 38381, 3: 83607 }) == { 1: 38381, 3: 83607 }

def test_check():
    check(f)

test_check()
