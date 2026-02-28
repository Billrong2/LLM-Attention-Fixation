from typing import List

def f(a: str) -> List[str]:    
    a = a.replace('/', ':')
    z = a.rpartition(':')
    return [z[0], z[1], z[2]]

def check(candidate):
    assert candidate('/CL44     ') == ['', ':', 'CL44     ']

def test_check():
    check(f)

test_check()
