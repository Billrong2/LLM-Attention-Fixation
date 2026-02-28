def f(text: str, repl: str) -> str:    
    trans = str.maketrans(text.lower(), repl.lower())
    return text.translate(trans)

def check(candidate):
    assert candidate('upper case', 'lower case') == 'lwwer case'

def test_check():
    check(f)

test_check()
