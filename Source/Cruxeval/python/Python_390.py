def f(text: str) -> int:    
    if not text.strip():
        return len(text.strip())
    return None

def check(candidate):
    assert candidate(' \t ') == 0

def test_check():
    check(f)

test_check()
