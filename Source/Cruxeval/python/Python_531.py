def f(text: str, x: str) -> str:    
    if text.removeprefix(x) == text:
        return f(text[1:], x)
    else:
        return text

def check(candidate):
    assert candidate('Ibaskdjgblw asdl ', 'djgblw') == 'djgblw asdl '

def test_check():
    check(f)

test_check()
