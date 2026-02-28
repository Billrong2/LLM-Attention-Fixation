from typing import Tuple

def f(s: str, sep: str) -> Tuple[str, str, str]:    
    sep_index = s.find(sep)
    prefix = s[:sep_index]
    middle = s[sep_index:sep_index + len(sep)]
    right_str = s[sep_index + len(sep):]
    return prefix, middle, right_str

def check(candidate):
    assert candidate('not it', '') == ('', '', 'not it')

def test_check():
    check(f)

test_check()
