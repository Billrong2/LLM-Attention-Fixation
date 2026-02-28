from typing import List

def f(lst: List[str]) -> List[int]:    
    lst.clear()
    lst += [1] * (len(lst) + 1)
    return lst

def check(candidate):
    assert candidate(['a', 'c', 'v']) == [1]

def test_check():
    check(f)

test_check()
