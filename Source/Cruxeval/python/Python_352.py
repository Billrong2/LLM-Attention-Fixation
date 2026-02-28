from typing import List

def f(nums: List[int]) -> int:    
    return nums[len(nums)//2]

def check(candidate):
    assert candidate([-1, -3, -5, -7, 0]) == -5

def test_check():
    check(f)

test_check()
