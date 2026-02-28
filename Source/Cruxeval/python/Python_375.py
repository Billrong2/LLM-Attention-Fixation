def f(a: str, b: str) -> str:    
    if b in a:
        return b.join(a.partition(a[a.index(b) + 1]))
    else:
        return a

def check(candidate):
    assert candidate('sierizam', 'iz') == 'sieriizzizam'

def test_check():
    check(f)

test_check()
