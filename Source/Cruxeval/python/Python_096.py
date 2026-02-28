def f(text: str) -> bool:    
    return not any([c.isupper() for c in text])

def check(candidate):
    assert candidate('lunabotics') == True

def test_check():
    check(f)

test_check()
