from typing import List

def f(strings: List[str]) -> List[str]:    
    new_strings = []
    for string in strings:
        first_two = string[:2]
        if first_two.startswith('a') or first_two.startswith('p'):
            new_strings.append(first_two)

    return new_strings

def check(candidate):
    assert candidate(['a', 'b', 'car', 'd']) == ['a']

def test_check():
    check(f)

test_check()
