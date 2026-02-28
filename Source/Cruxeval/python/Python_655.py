def f(s: str) -> str:    
    return s.replace('a', '').replace('r', '')

def check(candidate):
    assert candidate('rpaar') == 'p'

def test_check():
    check(f)

test_check()
