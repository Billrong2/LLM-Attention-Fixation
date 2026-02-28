def f(string: str) -> str:    
    count = string.count(':')
    return string.replace(':', '', count - 1)

def check(candidate):
    assert candidate('1::1') == '1:1'

def test_check():
    check(f)

test_check()
