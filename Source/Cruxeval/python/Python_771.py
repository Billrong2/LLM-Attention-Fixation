from typing import Tuple, List

def f(items: List[int]) -> List[int]:    
    odd_positioned = []
    while len(items) > 0:
        position = items.index(min(items))
        items.pop(position)
        item = items.pop(position)
        odd_positioned.append(item)
    return odd_positioned

def check(candidate):
    assert candidate([1, 2, 3, 4, 5, 6, 7, 8]) == [2, 4, 6, 8]

def test_check():
    check(f)

test_check()
