def f(text: str, num_digits: int) -> str:    
    width = max(1, num_digits)
    return text.zfill(width)

def check(candidate):
    assert candidate('19', 5) == '00019'

def test_check():
    check(f)

test_check()
