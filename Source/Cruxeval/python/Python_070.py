def f(x: str) -> int:    
    a = 0
    for i in x.split(' '):
        a += len(i.zfill(len(i)*2))
    return a

def check(candidate):
    assert candidate('999893767522480') == 30

def test_check():
    check(f)

test_check()
