from typing import List

def f(array: List[int]) -> List[str]:    
    array.reverse()
    array.clear()
    array.extend('x'*len(array))
    array.reverse()
    return array

def check(candidate):
    assert candidate([3, -2, 0]) == []

def test_check():
    check(f)

test_check()
