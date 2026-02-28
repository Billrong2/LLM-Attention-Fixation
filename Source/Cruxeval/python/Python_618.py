def f(match: str, fill: str, n: int) -> str:    
    return fill[:n] + match

def check(candidate):
    assert candidate('9', '8', 2) == '89'

def test_check():
    check(f)

test_check()
