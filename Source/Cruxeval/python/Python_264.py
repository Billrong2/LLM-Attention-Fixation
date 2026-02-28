def f(test_str: str) -> str:    
    s = test_str.replace('a', 'A')
    return s.replace('e', 'A')

def check(candidate):
    assert candidate('papera') == 'pApArA'

def test_check():
    check(f)

test_check()
