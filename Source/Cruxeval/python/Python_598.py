def f(text: str, n: int) -> str:    
    length = len(text)
    return text[length*(n%4):length ]

def check(candidate):
    assert candidate('abc', 1) == ''

def test_check():
    check(f)

test_check()
