from typing import List, Any

def f(numbers: List[int], elem: int, idx: int) -> List[int]:    
    numbers.insert(idx, elem)
    return numbers

def check(candidate):
    assert candidate([1, 2, 3], 8, 5) == [1, 2, 3, 8]

def test_check():
    check(f)

test_check()
