from typing import List

def f(nums: List[int]) -> List[int]:    
    for i in range(len(nums)):
        nums.insert(i, nums[i]**2)
    return nums

def check(candidate):
    assert candidate([1, 2, 4]) == [1, 1, 1, 1, 2, 4]

def test_check():
    check(f)

test_check()
