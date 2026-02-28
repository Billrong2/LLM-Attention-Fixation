def f(text: str) -> str:    
    if text.isidentifier():
        return ''.join(c for c in text if c.isdigit())
    else:
        return ''.join(text)

def check(candidate):
    assert candidate('816') == '816'

def test_check():
    check(f)

test_check()
