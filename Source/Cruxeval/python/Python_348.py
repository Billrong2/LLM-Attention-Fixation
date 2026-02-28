from typing import Dict, Optional

def f(dictionary: Dict[int, Optional[int]]) -> Dict[int, Optional[int]]:    
    return dictionary.copy()

def check(candidate):
    assert candidate({ 563: 555, 133: None }) == { 563: 555, 133: None }

def test_check():
    check(f)

test_check()
