from typing import List

def f(nums: List[int], pos: int) -> List[int]:    
    s = slice(None)
    if pos % 2:
        s = slice(None, -1)
    nums[s].reverse()
    return nums

def check(candidate):
    assert candidate([6, 1], 3) == [6, 1]

def test_check():
    check(f)

test_check()
