def f(text: str) -> str:    
    a = []
    for i in range(len(text)):
        if not text[i].isdecimal():
            a.append(text[i])
    return ''.join(a)

def check(candidate):
    assert candidate('seiq7229 d27') == 'seiq d'

def test_check():
    check(f)

test_check()
