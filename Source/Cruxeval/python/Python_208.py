from typing import List

def f(items: List[str]) -> List[str]:    
    result = []
    for item in items:
        for d in item:
            if not d.isdigit():
                result.append(d)
    return result

def check(candidate):
    assert candidate(['123', 'cat', 'd dee']) == ['c', 'a', 't', 'd', ' ', 'd', 'e', 'e']

def test_check():
    check(f)

test_check()
