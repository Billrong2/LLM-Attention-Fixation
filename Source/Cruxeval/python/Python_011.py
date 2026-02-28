from typing import Dict,List

def f(a: Dict[str, List[str]], b: Dict[str, str]) -> Dict[str, List[str]]:    
    for key, value in b.items():
        if key not in a:
            a[key] = [value]
        else:
            a[key].append(value)
    return a

def check(candidate):
    assert candidate({  }, { 'foo': 'bar' }) == { 'foo': ['bar'] }

def test_check():
    check(f)

test_check()
