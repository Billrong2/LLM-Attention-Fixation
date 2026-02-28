def f(text: str, value: str) -> str:    
    ls = list(text)
    if (ls.count(value)) % 2 == 0:
        while value in ls:
            ls.remove(value)
    else:
        ls.clear()
    return ''.join(ls)

def check(candidate):
    assert candidate('abbkebaniuwurzvr', 'm') == 'abbkebaniuwurzvr'

def test_check():
    check(f)

test_check()
