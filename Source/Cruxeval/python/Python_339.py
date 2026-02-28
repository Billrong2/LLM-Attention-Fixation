from typing import List

def f(array: List[int], elem: int) -> int:    
    elem = str(elem)
    d = 0
    for i in array:
        if str(i) == elem:
            d += 1
    return d

def check(candidate):
    assert candidate([-1, 2, 1, -8, -8, 2], 2) == 2

def test_check():
    check(f)

test_check()
