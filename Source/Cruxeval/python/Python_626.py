from typing import List, Tuple

def f(line: str, equalityMap: List[Tuple[str, str]]) -> str:    
    rs = {
        k[0]: k[1] for k in equalityMap
    }
    return line.translate(str.maketrans(rs))

def check(candidate):
    assert candidate('abab', [('a', 'b'), ('b', 'a')]) == 'baba'

def test_check():
    check(f)

test_check()
