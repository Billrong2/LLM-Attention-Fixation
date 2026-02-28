def f(w: str) -> bool:    
    ls = list(w)
    omw = ''
    while len(ls) > 0:
        omw += ls.pop(0)
        if len(ls) * 2 > len(w):
            return w[len(ls):] == omw
    return False

def check(candidate):
    assert candidate('flak') == False

def test_check():
    check(f)

test_check()
