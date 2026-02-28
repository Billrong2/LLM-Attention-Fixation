from typing import List

def f(fruits: List[str]) -> List[str]:
    if fruits[-1] == fruits[0]:
        return 'no'
    else:
        fruits.pop(0)
        fruits.pop()
        fruits.pop(0)
        fruits.pop()
        return fruits

def check(candidate):
    assert candidate(['apple', 'apple', 'pear', 'banana', 'pear', 'orange', 'orange']) == ['pear', 'banana', 'pear']

def test_check():
    check(f)

test_check()
