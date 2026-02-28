def f(s: str, amount: int) -> str:    
    return (amount - len(s)) * 'z' + s

def check(candidate):
    assert candidate('abc', 8) == 'zzzzzabc'

def test_check():
    check(f)

test_check()
