def f(integer: int, n: int) -> str:    
    i = 1
    text = str(integer)
    while (i+len(text) < n):
        i += len(text)
    return text.zfill(i+len(text))

def check(candidate):
    assert candidate(8999, 2) == '08999'

def test_check():
    check(f)

test_check()
