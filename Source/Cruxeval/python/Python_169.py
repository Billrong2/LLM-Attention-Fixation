def f(text: str) -> str:    
    ls = list(text)
    total = (len(text) - 1) * 2
    for i in range(1, total+1):
        if i % 2:
            ls.append('+')
        else:
            ls.insert(0, '+')
    return ''.join(ls).rjust(total)

def check(candidate):
    assert candidate('taole') == '++++taole++++'

def test_check():
    check(f)

test_check()
