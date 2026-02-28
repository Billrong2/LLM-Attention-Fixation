from typing import List

def f(nums: List[int]) -> bool:    
    if nums[::-1] == nums:
        return True
    return False

def check(candidate):
    assert candidate([0, 3, 6, 2]) == False

def test_check():
    check(f)

test_check()
