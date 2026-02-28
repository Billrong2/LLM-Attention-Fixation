from typing import Dict, Union

def f(d: Dict[str, int]) -> Dict[int, Union[bool, bool]]:    
    d['luck'] = 42
    d.clear()
    return {1: False, 2 :True}

def check(candidate):
    assert candidate({  }) == { 1: False, 2: True }

def test_check():
    check(f)

test_check()
