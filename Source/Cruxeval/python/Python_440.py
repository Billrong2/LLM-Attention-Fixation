def f(text: str) -> str:    
    if text.isdecimal():
        return 'yes'
    else:
        return 'no'

def check(candidate):
    assert candidate('abc') == 'no'

def test_check():
    check(f)

test_check()
