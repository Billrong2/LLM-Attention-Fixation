from typing import List

def f(nums: List[int]) -> List[int]:    
    count = len(nums)
    for i in [i % 2 for i in range(count)]:
        nums.append(nums[i])
    return nums

def check(candidate):
    assert candidate([-1, 0, 0, 1, 1]) == [-1, 0, 0, 1, 1, -1, 0, -1, 0, -1]

def test_check():
    check(f)

test_check()
