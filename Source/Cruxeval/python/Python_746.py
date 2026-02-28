from typing import Dict

def f(dct: Dict[str, str]) -> Dict[str, str]:    
    values = dct.values()
    result = {}
    for value in values:
        item = value.split('.')[0]+'@pinc.uk'
        result[value] = item
    return result

def check(candidate):
    assert candidate({  }) == {  }

def test_check():
    check(f)

test_check()
