def f(text: str, value: str) -> str:    
    if not value in text:
        return ''
    return text.rpartition(value)[0]

def check(candidate):
    assert candidate('mmfbifen', 'i') == 'mmfb'

def test_check():
    check(f)

test_check()
