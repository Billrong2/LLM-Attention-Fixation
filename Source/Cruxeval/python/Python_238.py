from typing import List, Union

def f(ls: List[List[int]], n: int) -> Union[List[int], int]:    
    answer = 0
    for i in ls:
        if i[0] == n:
            answer = i
    return answer

def check(candidate):
    assert candidate([[1, 9, 4], [83, 0, 5], [9, 6, 100]], 1) == [1, 9, 4]

def test_check():
    check(f)

test_check()
