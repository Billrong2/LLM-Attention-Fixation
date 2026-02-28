from typing import List

def f(n: int, array: List[int]) -> List[List[int]]:    
    final = [array.copy()] 
    for i in range(n):
        arr = array.copy()
        arr.extend(final[-1])
        final.append(arr)
    return final

def check(candidate):
    assert candidate(1, [1, 2, 3]) == [[1, 2, 3], [1, 2, 3, 1, 2, 3]]

def test_check():
    check(f)

test_check()
