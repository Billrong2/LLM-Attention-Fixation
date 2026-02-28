from typing import List

def f(text: str) -> List[int]:    
    occ = {}
    for ch in text:
        name = {'a': 'b', 'b': 'c', 'c': 'd', 'd': 'e', 'e': 'f'}
        name = name.get(ch, ch)
        occ[name] = occ.get(name, 0) + 1
    return [x for _, x in occ.items()]

def check(candidate):
    assert candidate('URW rNB') == [1, 1, 1, 1, 1, 1, 1]

def test_check():
    check(f)

test_check()
