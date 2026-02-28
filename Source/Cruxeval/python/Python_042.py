from typing import List

def f(nums: List[int]) -> List[int]:    
    nums.clear()
    for num in nums:
        nums.append(num*2)
    return nums

def check(candidate):
    assert candidate([4, 3, 2, 1, 2, -1, 4, 2]) == []

def test_check():
    check(f)

test_check()
