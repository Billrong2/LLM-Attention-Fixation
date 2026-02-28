from typing import Dict, Any

def f(a: Dict[int, str]) -> str:    
    s = dict(list(a.items())
    [::-1])
    return " ".join([str(i) for i in s.items()])

def check(candidate):
    assert candidate({ 15: 'Qltuf', 12: 'Rwrepny' }) == "(12, 'Rwrepny') (15, 'Qltuf')"

def test_check():
    check(f)

test_check()
