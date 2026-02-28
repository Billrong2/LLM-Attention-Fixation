from typing import List

def f(xs: List[int]) -> List[int]:    
    for idx in reversed(range(-len(xs)-1, -1)):
        xs.insert(idx, xs.pop(0))
    return xs

def check(candidate):
    assert candidate([1, 2, 3]) == [1, 2, 3]

def test_check():
    check(f)

test_check()
