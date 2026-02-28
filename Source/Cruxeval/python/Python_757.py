def f(text: str, char: str, replace: str) -> str:    
    return text.replace(char, replace)

def check(candidate):
    assert candidate('a1a8', '1', 'n2') == 'an2a8'

def test_check():
    check(f)

test_check()
