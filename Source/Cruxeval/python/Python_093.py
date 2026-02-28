def f(n: str) -> str:    
    length = len(n) + 2
    revn = list(n)
    result = ''.join(revn)
    revn.clear()
    return result + ('!' * length)

def check(candidate):
    assert candidate('iq') == 'iq!!!!'

def test_check():
    check(f)

test_check()
