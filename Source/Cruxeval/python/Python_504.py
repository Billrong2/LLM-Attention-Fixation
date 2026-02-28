from typing import List

def f(values: List[int]) -> List[int]:    
    values.sort()
    return values

def check(candidate):
    assert candidate([1, 1, 1, 1]) == [1, 1, 1, 1]

def test_check():
    check(f)

test_check()
