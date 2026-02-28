from typing import List

def f(values: List[str]) -> List[str]:    
    names = ['Pete', 'Linda', 'Angela']
    names.extend(values)
    names.sort()
    return names

def check(candidate):
    assert candidate(['Dan', 'Joe', 'Dusty']) == ['Angela', 'Dan', 'Dusty', 'Joe', 'Linda', 'Pete']

def test_check():
    check(f)

test_check()
