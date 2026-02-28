def f(a_str: str, prefix: str) -> str:    
    if a_str.removeprefix(prefix):
        return a_str
    else:
        return prefix + a_str

def check(candidate):
    assert candidate('abc', 'abcd') == 'abc'

def test_check():
    check(f)

test_check()
