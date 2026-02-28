def f(text: str) -> str:    
    ls = list(text)
    length = len(ls)
    for i in range(length):
        ls.insert(i, ls[i])
    return ''.join(ls).ljust(length * 2)

def check(candidate):
    assert candidate('hzcw') == 'hhhhhzcw'

def test_check():
    check(f)

test_check()
