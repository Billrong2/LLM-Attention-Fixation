def f(n: str) -> str:    
    n = str(n)
    return n[0] + '.'+n[1:].replace('-', '_')

def check(candidate):
    assert candidate('first-second-third') == 'f.irst_second_third'

def test_check():
    check(f)

test_check()
