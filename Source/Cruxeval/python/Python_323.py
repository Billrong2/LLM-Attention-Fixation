def f(text: str) -> int:    
    return len(text.splitlines())

def check(candidate):
    assert candidate('ncdsdfdaaa0a1cdscsk*XFd') == 1

def test_check():
    check(f)

test_check()
