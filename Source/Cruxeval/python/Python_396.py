from typing import Dict

def f(ets: Dict[int, int]) -> Dict[int, int]:
    while ets:
        k, v = ets.popitem()
        ets[k] = v**2
    return ets

def check(candidate):
    assert candidate({  }) == {  }

def test_check():
    check(f)

test_check()
