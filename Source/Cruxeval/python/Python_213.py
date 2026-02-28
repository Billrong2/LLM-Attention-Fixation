def f(s: str) -> str:    
    return s.replace('(', '[').replace(')', ']')

def check(candidate):
    assert candidate('(ac)') == '[ac]'

def test_check():
    check(f)

test_check()
