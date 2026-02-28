def f(s: str, char: str) -> str:
    base = char * (s.count(char) + 1)
    return s.removesuffix(base)

def check(candidate):
    assert candidate('mnmnj krupa...##!@#!@#$$@##', '@') == 'mnmnj krupa...##!@#!@#$$@##'

def test_check():
    check(f)

test_check()
