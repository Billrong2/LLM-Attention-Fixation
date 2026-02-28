from typing import List

def f(array: List[str]) -> str:    
    s = ' '
    s += ''.join(array)
    return s

def check(candidate):
    assert candidate([' ', '  ', '    ', '   ']) == '           '

def test_check():
    check(f)

test_check()
