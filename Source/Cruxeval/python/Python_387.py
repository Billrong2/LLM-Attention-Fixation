from typing import List

def f(nums: List[int], pos: int, value: int) -> List[int]:    
    nums.insert(pos, value)
    return nums

def check(candidate):
    assert candidate([3, 1, 2], 2, 0) == [3, 1, 0, 2]

def test_check():
    check(f)

test_check()
