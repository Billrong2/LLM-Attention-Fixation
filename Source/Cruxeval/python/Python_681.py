from typing import List

def f(array: List[int], ind: int, elem: int) -> List[int]:    
    array.insert(-5 if ind < 0 else len(array) if ind > len(array) else ind + 1, elem)
    return array

def check(candidate):
    assert candidate([1, 5, 8, 2, 0, 3], 2, 7) == [1, 5, 8, 7, 2, 0, 3]

def test_check():
    check(f)

test_check()
