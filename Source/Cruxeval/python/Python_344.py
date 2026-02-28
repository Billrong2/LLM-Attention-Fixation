from typing import List, Callable

def f(lst: List[int]) -> List[int]:
    operation = lambda x: x.reverse()
    new_list = lst[:]
    new_list.sort()
    operation(new_list)
    return lst

def check(candidate):
    assert candidate([6, 4, 2, 8, 15]) == [6, 4, 2, 8, 15]

def test_check():
    check(f)

test_check()
