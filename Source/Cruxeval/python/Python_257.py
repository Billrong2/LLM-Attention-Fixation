from typing import List

def f(text: List[str]) -> List[List[str]]:    
    ls = []
    for x in text:
        ls.append(x.splitlines())
    return ls

def check(candidate):
    assert candidate(['Hello World\n"I am String"']) == [['Hello World', '"I am String"']]

def test_check():
    check(f)

test_check()
