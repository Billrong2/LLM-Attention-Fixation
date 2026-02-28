from typing import List

def f(nums: List[int], elements: List[int]) -> List[int]:    
    result = []
    for i in range(len(elements)):
        result.append(nums.pop())
    return nums

def check(candidate):
    assert candidate([7, 1, 2, 6, 0, 2], [9, 0, 3]) == [7, 1, 2]

def test_check():
    check(f)

test_check()
