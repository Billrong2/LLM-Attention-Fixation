def f(prefix: str, s: str) -> str:    
    return str.removeprefix(prefix, s)

def check(candidate):
    assert candidate('hymi', 'hymifulhxhzpnyihyf') == 'hymi'

def test_check():
    check(f)

test_check()
