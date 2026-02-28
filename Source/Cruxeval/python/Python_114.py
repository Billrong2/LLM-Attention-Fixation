from typing import List

def f(text: str, sep: str) -> List[str]:    
    return text.rsplit(sep, maxsplit=2)

def check(candidate):
    assert candidate('a-.-.b', '-.') == ['a', '', 'b']

def test_check():
    check(f)

test_check()
