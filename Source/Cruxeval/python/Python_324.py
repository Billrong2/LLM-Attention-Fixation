from typing import List

def f(nums: List[int]) -> List[int]:    
    asc, desc = nums.copy(), []
    asc.reverse()
    desc = asc[:len(asc)//2]
    return desc + asc + desc

def check(candidate):
    assert candidate([]) == []

def test_check():
    check(f)

test_check()
