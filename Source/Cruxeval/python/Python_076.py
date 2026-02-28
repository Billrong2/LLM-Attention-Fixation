from typing import List

def f(nums: List[int]) -> List[int]:    
    nums = [y for y in nums if y > 0]
    if len(nums) <= 3:
        return nums
    nums.reverse()
    half = len(nums)//2
    return nums[:half] + [0]*5 + nums[half:]

def check(candidate):
    assert candidate([10, 3, 2, 2, 6, 0]) == [6, 2, 0, 0, 0, 0, 0, 2, 3, 10]

def test_check():
    check(f)

test_check()
