from typing import List

def f(array: List[int], lst: List[int]) -> List[int]:    
    array.extend(lst)
    [e for e in array if e % 2 == 0]
    return [e for e in array if e >= 10]

def check(candidate):
    assert candidate([2, 15], [15, 1]) == [15, 15]

def test_check():
    check(f)

test_check()
