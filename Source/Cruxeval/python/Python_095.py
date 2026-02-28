from typing import Dict

def f(zoo: Dict[str, str]) -> Dict[str, str]:    
    return dict((v, k) for k, v in zoo.items())

def check(candidate):
    assert candidate({ 'AAA': 'fr' }) == { 'fr': 'AAA' }

def test_check():
    check(f)

test_check()
