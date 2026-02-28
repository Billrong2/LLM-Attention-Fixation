from typing import List

def f(arr: List[int]) -> str:    
    arr = list(arr)
    arr.clear()
    arr.append('1')
    arr.append('2')
    arr.append('3')
    arr.append('4')
    return ','.join(arr)

def check(candidate):
    assert candidate([0, 1, 2, 3, 4]) == '1,2,3,4'

def test_check():
    check(f)

test_check()
