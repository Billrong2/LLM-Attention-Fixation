def f(x: str) -> str:    
    if x.islower():
        return x
    else:
        return x[::-1]

def check(candidate):
    assert candidate('ykdfhp') == 'ykdfhp'

def test_check():
    check(f)

test_check()
