def f(text: str, char: str) -> str:    
    return ' '.join(text.split(char, len(text)))

def check(candidate):
    assert candidate('a', 'a') == ' '

def test_check():
    check(f)

test_check()
