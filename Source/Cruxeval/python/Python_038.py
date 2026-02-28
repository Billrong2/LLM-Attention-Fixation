def f(string: str) -> str:    
    return string.title().replace(' ', '')

def check(candidate):
    assert candidate('1oE-err bzz-bmm') == '1Oe-ErrBzz-Bmm'

def test_check():
    check(f)

test_check()
