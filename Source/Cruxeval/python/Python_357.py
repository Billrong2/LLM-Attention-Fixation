def f(s: str) -> str:    
    r = []
    for i in range(len(s) - 1, 0 - 1, -1):
        r += s[i]
    return ''.join(r)

def check(candidate):
    assert candidate('crew') == 'werc'

def test_check():
    check(f)

test_check()
