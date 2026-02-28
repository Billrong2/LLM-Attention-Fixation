from typing import List

def f(array: List[int]) -> List[int]:    
    for i in range(len(array)):
        if array[i] < 0:
            array.pop(i)
    return array

def check(candidate):
    assert candidate([]) == []

def test_check():
    check(f)

test_check()
