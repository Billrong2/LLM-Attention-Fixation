from typing import List

def f(arr: List[int]) -> List[int]:    
    return list(reversed(arr))

def check(candidate):
    assert candidate([2, 0, 1, 9999, 3, -5]) == [-5, 3, 9999, 1, 0, 2]

def test_check():
    check(f)

test_check()
