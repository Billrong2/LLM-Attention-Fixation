from typing import List

def f(array: List[int], values: List[int]) -> List[int]:    
    array.reverse()
    for value in values:
        array.insert(len(array) // 2, value)
    array.reverse()
    return array

def check(candidate):
    assert candidate([58], [21, 92]) == [58, 92, 21]

def test_check():
    check(f)

test_check()
