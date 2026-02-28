def f(s: str, n: int) -> str:
    if len(s) < n:
        return s
    else:
        return s.removeprefix(s[:n])

def check(candidate):
    assert candidate('try.', 5) == 'try.'

def test_check():
    check(f)

test_check()
