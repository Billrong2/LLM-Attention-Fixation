def f(text: str, suffix: str) -> str:    
    if suffix and text and text.endswith(suffix):
        return text.removesuffix(suffix)
    else:
        return text

def check(candidate):
    assert candidate('spider', 'ed') == 'spider'

def test_check():
    check(f)

test_check()
