def f(text: str, num: int) -> str:    
    req = num - len(text)
    text = text.center(num, '*')
    return text[:req // 2: -req // 2]

def check(candidate):
    assert candidate('a', 19) == '*'

def test_check():
    check(f)

test_check()
