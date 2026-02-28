from typing import Dict

def f(dictionary: Dict[int, int]) -> Dict[str, int]:
    a = dictionary.copy()
    for key in a:
        if key%2 != 0:
            del a[key]
            a['$'+str(key)] = a[key]
    return a

def check(candidate):
    assert candidate({  }) == {  }

def test_check():
    check(f)

test_check()
