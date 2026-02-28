def f(n: str) -> str:    
    if str(n).find('.') != -1:
        return str(int(n)+2.5)
    return str(n)

def check(candidate):
    assert candidate('800') == '800'

def test_check():
    check(f)

test_check()
