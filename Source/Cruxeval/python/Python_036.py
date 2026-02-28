def f(text: str, chars: str) -> str:    
    return text.rstrip(chars) if text else text

def check(candidate):
    assert candidate('ha', '') == 'ha'

def test_check():
    check(f)

test_check()
