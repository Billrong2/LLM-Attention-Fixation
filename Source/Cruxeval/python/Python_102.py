from typing import List

def f(names: List[str], winners: List[str]) -> List[int]:    
    ls = [names.index(name) for name in names if name in winners]
    ls.sort(reverse=True)
    return ls

def check(candidate):
    assert candidate(['e', 'f', 'j', 'x', 'r', 'k'], ['a', 'v', '2', 'im', 'nb', 'vj', 'z']) == []

def test_check():
    check(f)

test_check()
