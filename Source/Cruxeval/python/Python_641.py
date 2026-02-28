def f(number: str) -> bool:    
    return True if number.isdecimal() else False

def check(candidate):
    assert candidate('dummy33;d') == False

def test_check():
    check(f)

test_check()
