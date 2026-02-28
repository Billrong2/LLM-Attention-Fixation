def f(text: str) -> str:    
    text = list(text)
    for i in range(len(text)):
        if i % 2 == 1:
            text[i] = text[i].swapcase()
    return ''.join(text)

def check(candidate):
    assert candidate('Hey DUdE THis $nd^ &*&this@#') == 'HEy Dude tHIs $Nd^ &*&tHiS@#'

def test_check():
    check(f)

test_check()
