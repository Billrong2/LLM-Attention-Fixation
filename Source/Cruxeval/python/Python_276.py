from typing import List

def f(a: List[int]) -> List[int]:    
    if len(a) >= 2 and a[0] > 0 and a[1] > 0:
        a.reverse()
        return a
    a.append(0)
    return a

def check(candidate):
    assert candidate([]) == [0]

def test_check():
    check(f)

test_check()
