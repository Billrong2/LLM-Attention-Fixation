from typing import List

def f(nums: List[int]) -> List[int]:    
    for i in range(len(nums)):
        if not i % 2:
            nums.append(nums[i] * nums[i + 1])
    return nums

def check(candidate):
    assert candidate([]) == []

def test_check():
    check(f)

test_check()
