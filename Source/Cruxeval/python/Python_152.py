def f(text: str) -> int:    
    n = 0
    for char in text:
        if char.isupper():
            n += 1
    return n

def check(candidate):
    assert candidate('AAAAAAAAAAAAAAAAAAAA') == 20

def test_check():
    check(f)

test_check()
