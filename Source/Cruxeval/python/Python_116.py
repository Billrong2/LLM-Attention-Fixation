from typing import Dict

def f(d: Dict[int,int], count: int) -> Dict[int,int]:    
    for i in range(count):
        if d == {}:
            break
        d.popitem()
    return d

def check(candidate):
    assert candidate({  }, 200) == {  }

def test_check():
    check(f)

test_check()
