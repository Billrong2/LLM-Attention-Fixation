from typing import List

def f(nums: List[int]) -> List[int]:    
    count = 0
    for i in range(len(nums)):
        if len(nums) == 0:
            break
        if count % 2 == 0:
            nums.pop()
        else:
            nums.pop(0)
        count += 1
    return nums

def check(candidate):
    assert candidate([3, 2, 0, 0, 2, 3]) == []

def test_check():
    check(f)

test_check()
