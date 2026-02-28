def f(text: str, char: str) -> bool:    
    return text.count(char) % 2 != 0

def check(candidate):
    assert candidate('abababac', 'a') == False

def test_check():
    check(f)

test_check()
