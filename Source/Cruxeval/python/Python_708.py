def f(string: str) -> str:    
    l = list(string)
    for i in reversed(range(len(l))):
        if l[i] != ' ':
            break
        l.pop(i)
    return ''.join(l)

def check(candidate):
    assert candidate('    jcmfxv     ') == '    jcmfxv'

def test_check():
    check(f)

test_check()
