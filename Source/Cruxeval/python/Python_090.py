from typing import List

def f(array: List[List[int]]) -> List[List[int]]:    
    return_arr = []
    for a in array:
        return_arr.append(a.copy())
    return return_arr

def check(candidate):
    assert candidate([[1, 2, 3], [], [1, 2, 3]]) == [[1, 2, 3], [], [1, 2, 3]]

def test_check():
    check(f)

test_check()
