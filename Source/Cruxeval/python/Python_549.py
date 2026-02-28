from typing import List

def f(matrix: List[List[int]]) -> List[List[int]]:    
    matrix.reverse()
    result = []
    for primary in matrix:
        max(primary)
        primary.sort(reverse = True)
        result.append(primary)
    return result

def check(candidate):
    assert candidate([[1, 1, 1, 1]]) == [[1, 1, 1, 1]]

def test_check():
    check(f)

test_check()
