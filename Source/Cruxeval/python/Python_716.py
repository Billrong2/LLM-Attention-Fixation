from typing import List

def f(nums: List[int]) -> List[int]:    
    count = len(nums)
    while len(nums) > (count//2):
        nums.clear()
    return nums

def check(candidate):
    assert candidate([2, 1, 2, 3, 1, 6, 3, 8]) == []

def test_check():
    check(f)

test_check()
