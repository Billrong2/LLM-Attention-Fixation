def f(text: str) -> str:    
    ls = list(text)
    for i in range(0, len(ls)):
        if ls[i]!='+':
            ls.insert(i, '+')
            ls.insert(i, '*')
            break
    return '+'.join(ls)

def check(candidate):
    assert candidate('nzoh') == '*+++n+z+o+h'

def test_check():
    check(f)

test_check()
