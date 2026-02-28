def f(a: str, b: str, c: str, d: str) -> str:    
    return a and b or c and d

def check(candidate):
    assert candidate('CJU', 'BFS', 'WBYDZPVES', 'Y') == 'BFS'

def test_check():
    check(f)

test_check()
