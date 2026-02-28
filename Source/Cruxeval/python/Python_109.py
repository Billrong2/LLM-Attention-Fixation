from typing import List

def f(nums: List[int], spot: int, idx: int) -> List[int]:    
    nums.insert(spot, idx)
    return nums

def check(candidate):
    assert candidate([1, 0, 1, 1], 0, 9) == [9, 1, 0, 1, 1]

def test_check():
    check(f)

test_check()
