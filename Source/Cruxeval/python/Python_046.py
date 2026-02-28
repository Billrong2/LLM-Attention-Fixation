from typing import List

def f(l: List[str], c: str) -> str:    
    return c.join(l)

def check(candidate):
    assert candidate(['many', 'letters', 'asvsz', 'hello', 'man'], '') == 'manylettersasvszhelloman'

def test_check():
    check(f)

test_check()
