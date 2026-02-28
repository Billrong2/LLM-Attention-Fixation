from typing import List

def f(a: List[int], b: List[int]) -> List[int]:    
    a.sort()
    b.sort(reverse=True)
    return a + b

def check(candidate):
    assert candidate([666], []) == [666]

def test_check():
    check(f)

test_check()
