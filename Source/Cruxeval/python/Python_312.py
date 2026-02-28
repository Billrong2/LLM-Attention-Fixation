def f(s: str) -> str:
    if s.isalnum():
        return "True"
    return "False"

def check(candidate):
    assert candidate('777') == 'True'

def test_check():
    check(f)

test_check()
