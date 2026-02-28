from typing import List

def f(lst: List[int]) -> List[int]:    
    lst.reverse()
    lst.pop()
    lst.reverse()
    return lst

def check(candidate):
    assert candidate([7, 8, 2, 8]) == [8, 2, 8]

def test_check():
    check(f)

test_check()
