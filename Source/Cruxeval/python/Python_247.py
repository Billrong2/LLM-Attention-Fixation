def f(s: str) -> str:    
    if s.isalpha():
        return "yes"
    if s == "":
        return "str is empty"
    return "no"

def check(candidate):
    assert candidate('Boolean') == 'yes'

def test_check():
    check(f)

test_check()
