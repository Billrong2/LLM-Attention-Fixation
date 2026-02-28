def f(s: str) -> str:    
    return ''.join([c for c in s if c.isspace()])

def check(candidate):
    assert candidate('\ngiyixjkvu\n\r\r \x0crgjuo') == '\n\n\r\r \x0c'

def test_check():
    check(f)

test_check()
