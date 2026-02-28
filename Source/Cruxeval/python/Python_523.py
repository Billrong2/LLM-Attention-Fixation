def f(text: str) -> str:    
    text = list(text)
    for i in range(len(text)-1, -1, -1):
        if text[i].isspace():
            text[i] = '&nbsp;'
    return ''.join(text)

def check(candidate):
    assert candidate('   ') == '&nbsp;&nbsp;&nbsp;'

def test_check():
    check(f)

test_check()
