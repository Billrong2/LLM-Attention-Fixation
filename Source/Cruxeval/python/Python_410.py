from typing import List

def f(nums: List[int]) -> List[int]:    
    a = 0
    for i in range(len(nums)):
        nums.insert(i, nums[a])
        a += 1
    return nums

def check(candidate):
    assert candidate([1, 3, -1, 1, -2, 6]) == [1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6]

def test_check():
    check(f)

test_check()
