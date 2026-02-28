def f(text: str) -> bool:    
    ls = list(text)
    ls[0], ls[-1] = ls[-1].upper(), ls[0].upper()
    return ''.join(ls).istitle()

def check(candidate):
    assert candidate('Josh') == False

def test_check():
    check(f)

test_check()
