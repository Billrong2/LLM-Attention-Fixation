from typing import List

def f(nums: List[int]) -> List[int]:    
    count = len(nums)
    for num in range(2, count):
        nums.sort()
    return nums

def check(candidate):
    assert candidate([-6, -5, -7, -8, 2]) == [-8, -7, -6, -5, 2]

def test_check():
    check(f)

test_check()
