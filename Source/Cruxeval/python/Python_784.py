from typing import Tuple

def f(key: str, value: str) -> Tuple[str, str]:    
    dict_ = {key: value}
    return dict.popitem(dict_)

def check(candidate):
    assert candidate('read', 'Is') == ('read', 'Is')

def test_check():
    check(f)

test_check()
