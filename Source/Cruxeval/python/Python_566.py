def f(string: str, code: str) -> str:    
    t = ''
    try:
        t = string.encode(code)
        if t.endswith(b'\n'):
            t = t[:-1]
        t = t.decode('UTF-8')
        return t
    except:
        return t

def check(candidate):
    assert candidate('towaru', 'UTF-8') == 'towaru'

def test_check():
    check(f)

test_check()
