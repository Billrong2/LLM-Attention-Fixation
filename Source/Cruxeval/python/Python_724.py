from typing import List

def f(text: str, function: str) -> List[int]:    
    cites = [len(text[text.index(function) + len(function):])]
    for char in text:
        if char == function:
            cites.append(len(text[text.index(function) + len(function):]))
    return cites

def check(candidate):
    assert candidate('010100', '010') == [3]

def test_check():
    check(f)

test_check()
