def f(letters: str, maxsplit: int) -> str:    
    return ''.join(letters.split()[-maxsplit:])

def check(candidate):
    assert candidate('elrts,SS ee', 6) == 'elrts,SSee'

def test_check():
    check(f)

test_check()
