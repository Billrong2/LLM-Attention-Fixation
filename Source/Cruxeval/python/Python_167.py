def f(XAAXX: str, s: str) -> str:    
    count = 0
    idx = -1
    while XAAXX.find('XXXX', idx+1) != -1:
        idx = XAAXX.find('XXXX', idx+1) 
        count += 1 
    compound = count * s.title()
    return XAAXX.replace('XXXX', compound)

def check(candidate):
    assert candidate('aaXXXXbbXXXXccXXXXde', 'QW') == 'aaQwQwQwbbQwQwQwccQwQwQwde'

def test_check():
    check(f)

test_check()
