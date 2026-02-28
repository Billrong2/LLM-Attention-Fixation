from typing import List

def f(lists: List[List[int]]) -> List[int]:
    lists[1].clear()
    lists[2] += lists[1]
    return lists[0]

def check(candidate):
    assert candidate([[395, 666, 7, 4], [], [4223, 111]]) == [395, 666, 7, 4]

def test_check():
    check(f)

test_check()
