from typing import List

def f(array: List[int]) -> List[int]:    
    n = array.pop()
    array.extend([n, n])
    return array

def check(candidate):
    assert candidate([1, 1, 2, 2]) == [1, 1, 2, 2, 2]

def test_check():
    check(f)

test_check()
