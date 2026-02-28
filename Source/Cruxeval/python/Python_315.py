def f(challenge: str) -> str:    
    return challenge.casefold().replace('l', ',')

def check(candidate):
    assert candidate('czywZ') == 'czywz'

def test_check():
    check(f)

test_check()
