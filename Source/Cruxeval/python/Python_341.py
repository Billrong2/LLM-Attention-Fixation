from typing import Dict

def f(cart: Dict[int,int]) -> Dict[int,int]:    
    while len(cart) > 5:
        cart.popitem()
    return cart

def check(candidate):
    assert candidate({  }) == {  }

def test_check():
    check(f)

test_check()
