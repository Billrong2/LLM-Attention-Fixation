def f(code: str) -> str:    
    return "{}: {}".format(code, code.encode())

def check(candidate):
    assert candidate('148') == "148: b'148'"

def test_check():
    check(f)

test_check()
