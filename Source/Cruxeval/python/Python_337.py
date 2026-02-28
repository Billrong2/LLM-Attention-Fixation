def f(txt: str) -> str:    
    d = []
    for c in txt:
        if c.isdigit():
            continue
        if c.islower():
            d.append(c.upper())
        elif c.isupper():
            d.append(c.lower())
    return ''.join(d)

def check(candidate):
    assert candidate('5ll6') == 'LL'

def test_check():
    check(f)

test_check()
