def f(s: str, from_c: str, to_c: str) -> str:    
    table = s.maketrans(from_c, to_c)
    return s.translate(table)

def check(candidate):
    assert candidate('aphid', 'i', '?') == 'aph?d'

def test_check():
    check(f)

test_check()
