from typing import List

def f(nums: List[int], val: int) -> int:    
    new_list = []
    [new_list.extend([i] * val) for i in nums]
    return sum(new_list)

def check(candidate):
    assert candidate([10, 4], 3) == 42

def test_check():
    check(f)

test_check()
