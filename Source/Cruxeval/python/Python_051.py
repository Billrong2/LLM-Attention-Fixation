from typing import Union

def f(num: int) -> Union[str, int]:    
    if num % 2 == 0:
        return s
    else:
        return num - 1

def check(candidate):
    assert candidate(21) == 20

def test_check():
    check(f)

test_check()
