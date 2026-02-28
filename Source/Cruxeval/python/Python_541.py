def f(text: str) -> bool:    
    return ''.join(list(text)).isspace()

def check(candidate):
    assert candidate(' \t  \u3000') == True

def test_check():
    check(f)

test_check()
