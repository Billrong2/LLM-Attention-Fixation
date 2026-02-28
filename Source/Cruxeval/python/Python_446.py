from typing import List

def f(array: List[int]) -> List[int]:    
    l = len(array)
    if l % 2 == 0:
        array.clear()
    else:
        array.reverse()
    return array

def check(candidate):
    assert candidate([]) == []

def test_check():
    check(f)

test_check()
