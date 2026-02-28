def f(text: str, char: str) -> str:    
    if char in text:
        if not text.startswith(char):
            text = text.replace(char,'')
    return text

def check(candidate):
    assert candidate('\\foo', '\\') == '\\foo'

def test_check():
    check(f)

test_check()
