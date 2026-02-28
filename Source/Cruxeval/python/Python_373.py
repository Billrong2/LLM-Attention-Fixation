from typing import List

def f(orig: List[int]) -> List[int]:    
    copy = orig
    copy.append(100)
    orig.pop()
    return copy

def check(candidate):
    assert candidate([1, 2, 3]) == [1, 2, 3]

def test_check():
    check(f)

test_check()
