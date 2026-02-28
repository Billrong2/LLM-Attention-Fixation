def f(text: str, suffix: str) -> str:    
    if suffix.startswith("/"):
        return text + suffix[1:]
    return text

def check(candidate):
    assert candidate('hello.txt', '/') == 'hello.txt'

def test_check():
    check(f)

test_check()
