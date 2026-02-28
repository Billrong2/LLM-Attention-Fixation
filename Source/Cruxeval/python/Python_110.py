def f(text: str) -> int:    
    a = ['']
    b = ''
    for i in text:
        if not i.isspace():
            a.append(b)
            b = ''
        else:
            b += i
    return len(a)

def check(candidate):
    assert candidate('       ') == 1

def test_check():
    check(f)

test_check()
