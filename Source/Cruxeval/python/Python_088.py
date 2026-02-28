def f(s1: str, s2: str) -> str:    
    if s2.endswith(s1):
        s2 = s2[:len(s1) * -1]
    return s2

def check(candidate):
    assert candidate('he', 'hello') == 'hello'

def test_check():
    check(f)

test_check()
