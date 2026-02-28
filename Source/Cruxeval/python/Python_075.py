from typing import List

def f(array: List[int], elem: int) -> int:    
    ind = array.index(elem)
    return ind * 2 + array[-ind - 1] * 3

def check(candidate):
    assert candidate([-1, 2, 1, -8, 2], 2) == -22

def test_check():
    check(f)

test_check()
