from typing import Dict, Any

def f(d: Dict[str, str]) -> Dict[str, str]:    
    d.clear()
    return d

def check(candidate):
    assert candidate({ 'a': '3', 'b': '-1', 'c': 'Dum' }) == {  }

def test_check():
    check(f)

test_check()
