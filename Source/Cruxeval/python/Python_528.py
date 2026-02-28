def f(s: str) -> int:    
    b = ''
    c = ''
    for i in s:
        c = c + i
        if s.rfind(c) > -1:
            return s.rfind(c)
    return 0

def check(candidate):
    assert candidate('papeluchis') == 2

def test_check():
    check(f)

test_check()
