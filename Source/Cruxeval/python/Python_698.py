def f(text: str) -> str:    
    return ''.join(x for x in text if x != ')')

def check(candidate):
    assert candidate('(((((((((((d))))))))).))))(((((') == '(((((((((((d.((((('

def test_check():
    check(f)

test_check()
