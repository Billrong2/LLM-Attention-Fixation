def f(s: str, c: str) -> str:    
    s = s.split(' ')
    return ((c + "  ") + ("  ".join(s[::-1])))

def check(candidate):
    assert candidate('Hello There', '*') == '*  There  Hello'

def test_check():
    check(f)

test_check()
