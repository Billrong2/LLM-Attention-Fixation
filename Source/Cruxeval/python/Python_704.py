def f(s: str, n: int, c: str) -> str:    
    width = len(c)*n
    for _ in range(width - len(s)):
        s = c + s
    return s

def check(candidate):
    assert candidate('.', 0, '99') == '.'

def test_check():
    check(f)

test_check()
