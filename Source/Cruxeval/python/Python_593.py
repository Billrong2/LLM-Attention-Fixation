from typing import List

def f(nums: List[int], n: int) -> List[int]:    
    pos = len(nums) - 1
    for i in range(-len(nums), 0):
        nums.insert(pos, nums[i])
    return nums

def check(candidate):
    assert candidate([], 14) == []

def test_check():
    check(f)

test_check()
