def f(s: str, sep: str) -> str:    
    reverse = ['*' + e for e in s.split(sep)]
    return ';'.join(reversed(reverse))

def check(candidate):
    assert candidate('volume', 'l') == '*ume;*vo'

def test_check():
    check(f)

test_check()
