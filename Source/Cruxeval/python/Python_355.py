def f(text: str, prefix: str) -> str:    
    return text[len(prefix):]

def check(candidate):
    assert candidate('123x John z', 'z') == '23x John z'

def test_check():
    check(f)

test_check()
