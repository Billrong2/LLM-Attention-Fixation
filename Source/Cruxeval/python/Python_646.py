def f(text: str, count: int) -> str:    
    for i in range(count):
        text = ''.join(reversed(text))
    return text

def check(candidate):
    assert candidate('aBc, ,SzY', 2) == 'aBc, ,SzY'

def test_check():
    check(f)

test_check()
