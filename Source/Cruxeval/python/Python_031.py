def f(string: str) -> int:    
    upper = 0
    for c in string:
        if c.isupper():
            upper += 1
    return upper * (2,1)[upper % 2]

def check(candidate):
    assert candidate('PoIOarTvpoead') == 8

def test_check():
    check(f)

test_check()
