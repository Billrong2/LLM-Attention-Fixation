def f(text: str) -> str:    
    length = len(text) // 2
    left_half = text[:length]
    right_half = text[length:][::-1]
    return left_half + right_half

def check(candidate):
    assert candidate('n') == 'n'

def test_check():
    check(f)

test_check()
