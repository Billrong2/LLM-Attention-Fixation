def f(string: str, c: str) -> bool:    
    return string.endswith(c)

def check(candidate):
    assert candidate('wrsch)xjmb8', 'c') == False

def test_check():
    check(f)

test_check()
