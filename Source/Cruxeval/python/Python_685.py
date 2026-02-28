from typing import List

def f(array: List[int], elem: int) -> int:    
    return array.count(elem) + elem

def check(candidate):
    assert candidate([1, 1, 1], -2) == -2

def test_check():
    check(f)

test_check()
