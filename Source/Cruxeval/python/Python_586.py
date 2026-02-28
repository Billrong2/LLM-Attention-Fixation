def f(text: str, char: str) -> int:    
    return text.rindex(char)

def check(candidate):
    assert candidate('breakfast', 'e') == 2

def test_check():
    check(f)

test_check()
