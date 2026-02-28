def f(text: str) -> int:    
    s = text.splitlines()
    return len(s)

def check(candidate):
    assert candidate('145\n\n12fjkjg') == 3

def test_check():
    check(f)

test_check()
