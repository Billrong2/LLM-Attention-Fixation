def f(text: str) -> str:    
    if text.isascii():
        return 'ascii'
    else:
        return 'non ascii'

def check(candidate):
    assert candidate('<<<<') == 'ascii'

def test_check():
    check(f)

test_check()
