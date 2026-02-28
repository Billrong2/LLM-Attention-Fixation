def f(text: str, suffix: str) -> bool:    
    if suffix == '':
        suffix = None
    return text.endswith(suffix)

def check(candidate):
    assert candidate('uMeGndkGh', 'kG') == False

def test_check():
    check(f)

test_check()
