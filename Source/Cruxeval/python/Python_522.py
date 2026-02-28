from typing import List

def f(numbers: List[int]) -> List[float]:    
    floats = [n % 1 for n in numbers]
    return floats if 1 in floats else []

def check(candidate):
    assert candidate([100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119]) == []

def test_check():
    check(f)

test_check()
