def f(text: str, char: str, min_count: int) -> str:    
    count = text.count(char)
    if count < min_count:
        return text.swapcase()
    return text

def check(candidate):
    assert candidate('wwwwhhhtttpp', 'w', 3) == 'wwwwhhhtttpp'

def test_check():
    check(f)

test_check()
