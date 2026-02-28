def f(text: str, char: str) -> bool:    
    if char in text:
        text = [t.strip() for t in text.split(char) if t]
        if len(text) > 1:
            return True
    return False

def check(candidate):
    assert candidate('only one line', ' ') == True

def test_check():
    check(f)

test_check()
