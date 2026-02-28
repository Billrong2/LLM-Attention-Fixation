from typing import List

def f(values: List[int], item1: int, item2: int) -> List[int]:    
    if values[-1] == item2:
        if values[0] not in values[1:]:
            values.append(values[0])
    elif values[-1] == item1:
        if values[0] == item2:
            values.append(values[0])
    return values

def check(candidate):
    assert candidate([1, 1], 2, 3) == [1, 1]

def test_check():
    check(f)

test_check()
