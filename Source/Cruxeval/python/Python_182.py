from typing import Dict, List, Tuple

def f(dic: Dict[str, int]) -> List[Tuple[str, int]]:    
    return sorted(dic.items(), key=lambda x: x[0])

def check(candidate):
    assert candidate({ 'b': 1, 'a': 2 }) == [('a', 2), ('b', 1)]

def test_check():
    check(f)

test_check()
