def f(s: str, n: str) -> bool:    
    return s.casefold() == n.casefold()

def check(candidate):
    assert candidate('daaX', 'daaX') == True

def test_check():
    check(f)

test_check()
