from typing import List

def f(nums: List[int], start: int, k: int) -> List[int]:    
    nums[start:start+k] = nums[start:start + k][::-1]
    return nums

def check(candidate):
    assert candidate([1, 2, 3, 4, 5, 6], 4, 2) == [1, 2, 3, 4, 6, 5]

def test_check():
    check(f)

test_check()
