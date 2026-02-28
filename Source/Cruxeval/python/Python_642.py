def f(text: str) -> str:    
    i = 0
    while i < len(text) and text[i].isspace():
        i+=1
    if i == len(text):
        return 'space'
    return 'no'

def check(candidate):
    assert candidate('     ') == 'space'

def test_check():
    check(f)

test_check()
