def f(s: str, o: str) -> str:    
    if s.startswith(o):
        return s
    return o + f(s, o[-2::-1])

def check(candidate):
    assert candidate('abba', 'bab') == 'bababba'

def test_check():
    check(f)

test_check()
