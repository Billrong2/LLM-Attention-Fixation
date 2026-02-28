def f(string: str) -> bool:    
    if string.isupper():
        return True
    else:
        return False

def check(candidate):
    assert candidate('Ohno') == False

def test_check():
    check(f)

test_check()
