from typing import List

def f(text: str, sub: str) -> List[int]:    
    index = []
    starting = 0
    while starting != -1:
        starting = text.find(sub, starting)
        if starting != -1:
            index.append(starting)
            starting += len(sub)
    return index

def check(candidate):
    assert candidate('egmdartoa', 'good') == []

def test_check():
    check(f)

test_check()
