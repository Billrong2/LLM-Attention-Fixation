from typing import Dict, List, Tuple

def f(dct: Dict[str, int]) -> List[Tuple[str, int]]:    
    lst = []
    for key in sorted(dct):
        lst.append((key, dct[key]))
    return lst

def check(candidate):
    assert candidate({ 'a': 1, 'b': 2, 'c': 3 }) == [('a', 1), ('b', 2), ('c', 3)]

def test_check():
    check(f)

test_check()
