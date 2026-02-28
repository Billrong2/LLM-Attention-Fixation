from typing import List

def f(nums: List[int], number: int) -> int:    
    return nums.count(number)

def check(candidate):
    assert candidate([12, 0, 13, 4, 12], 12) == 2

def test_check():
    check(f)

test_check()
