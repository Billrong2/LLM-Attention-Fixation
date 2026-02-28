def f(text: str) -> str:    
    if len(text) == 0:
        return ''
    text = text.lower()
    return text[0].upper() + text[1:]

def check(candidate):
    assert candidate('xzd') == 'Xzd'

def test_check():
    check(f)

test_check()
