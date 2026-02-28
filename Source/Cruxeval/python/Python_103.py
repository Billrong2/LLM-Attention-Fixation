def f(s: str) -> str:    
    return ''.join((c.casefold() for c in s))

def check(candidate):
    assert candidate('abcDEFGhIJ') == 'abcdefghij'

def test_check():
    check(f)

test_check()
