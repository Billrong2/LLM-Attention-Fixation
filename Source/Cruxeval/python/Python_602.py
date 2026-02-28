from typing import List

def f(nums: List[int], target: int) -> int:    
    cnt = nums.count(target)
    return cnt * 2

def check(candidate):
    assert candidate([1, 1], 1) == 4

def test_check():
    check(f)

test_check()
