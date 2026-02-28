from typing import List

def f(array: List[int]) -> List[int]:    
    output = array.copy()
    output[0::2] = output[-1::-2]
    output.reverse()
    return output

def check(candidate):
    assert candidate([]) == []

def test_check():
    check(f)

test_check()
