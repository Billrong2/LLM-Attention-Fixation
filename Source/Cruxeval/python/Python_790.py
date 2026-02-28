from typing import Dict, Any, Tuple

def f(d: Dict[str, str]) -> Tuple[bool, bool]:    
    r = {
        'c': d.copy(),
        'd': d.copy()
    }
    return (r['c'] is r['d'], r['c'] == r['d'])

def check(candidate):
    assert candidate({ 'i': '1', 'love': 'parakeets' }) == (False, True)

def test_check():
    check(f)

test_check()
