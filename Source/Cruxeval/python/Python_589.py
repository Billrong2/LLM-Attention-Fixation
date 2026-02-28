from typing import List

def f(num: List[int]) -> List[int]:    
    num.append(num[-1])
    return num

def check(candidate):
    assert candidate([-70, 20, 9, 1]) == [-70, 20, 9, 1, 1]

def test_check():
    check(f)

test_check()
