def f(text: str, froms: str) -> str:    
    text = text.lstrip(froms)
    text = text.rstrip(froms)
    return text

def check(candidate):
    assert candidate('0 t 1cos ', 'st 0\t\n  ') == '1co'

def test_check():
    check(f)

test_check()
