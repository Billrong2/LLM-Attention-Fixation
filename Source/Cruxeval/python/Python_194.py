from typing import List

def f(matr: List[List[int]], insert_loc: int) -> List[List[int]]:    
    matr.insert(insert_loc, [])
    return matr

def check(candidate):
    assert candidate([[5, 6, 2, 3], [1, 9, 5, 6]], 0) == [[], [5, 6, 2, 3], [1, 9, 5, 6]]

def test_check():
    check(f)

test_check()
