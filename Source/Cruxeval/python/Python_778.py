def f(prefix: str, text: str) -> str:    
    if text.startswith(prefix):
        return text
    else:
        return prefix + text

def check(candidate):
    assert candidate('mjs', 'mjqwmjsqjwisojqwiso') == 'mjsmjqwmjsqjwisojqwiso'

def test_check():
    check(f)

test_check()
