def f(text: str, delim: str) -> str:    
    first, second = text.split(delim)
    return second + delim + first

def check(candidate):
    assert candidate('bpxa24fc5.', '.') == '.bpxa24fc5'

def test_check():
    check(f)

test_check()
