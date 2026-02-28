def f(s: str, l: int) -> str:    
    return s.ljust(l, '=').rpartition('=')[0]

def check(candidate):
    assert candidate('urecord', 8) == 'urecord'

def test_check():
    check(f)

test_check()
