from typing import List

def f(nums: List[int], target: int) -> int:    
    count = 0
    for n1 in nums:
        for n2 in nums:
            count += (n1+n2==target)
    return count

def check(candidate):
    assert candidate([1, 2, 3], 4) == 3

def test_check():
    check(f)

test_check()
