def f(text: str, length: int, fillchar: str) -> str:    
    size = len(text)
    return text.center(length, fillchar)

def check(candidate):
    assert candidate('magazine', 25, '.') == '.........magazine........'

def test_check():
    check(f)

test_check()
