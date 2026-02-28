def f(string: str) -> int:    
    try:
       return string.rfind('e')
    except AttributeError:
        return "Nuk"

def check(candidate):
    assert candidate('eeuseeeoehasa') == 8

def test_check():
    check(f)

test_check()
