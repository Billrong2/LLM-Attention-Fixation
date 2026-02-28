def f(s: str) -> str:    
    return ''.join(reversed(s.rstrip()))

def check(candidate):
    assert candidate('ab        ') == 'ba'

def test_check():
    check(f)

test_check()
