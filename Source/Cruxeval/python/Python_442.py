from typing import List

def f(lst: List[int]) -> List[int]:    
    res = []
    for i in range(len(lst)):
        if lst[i] % 2 == 0:
            res.append(lst[i])

    return lst.copy()

def check(candidate):
    assert candidate([1, 2, 3, 4]) == [1, 2, 3, 4]

def test_check():
    check(f)

test_check()
