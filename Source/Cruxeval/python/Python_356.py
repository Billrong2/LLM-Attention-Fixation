from typing import List

def f(array: List[int], num: int) -> List[int]:    
    reverse = False
    if num < 0:
        reverse = True
        num *= -1
    array = array[::-1] * num
    l = len(array)
    
    if reverse:
        array = array[::-1]
    return array

def check(candidate):
    assert candidate([1, 2], 1) == [2, 1]

def test_check():
    check(f)

test_check()
