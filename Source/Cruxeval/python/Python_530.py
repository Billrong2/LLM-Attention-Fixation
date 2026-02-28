def f(s: str, ch: str) -> str:    
    sl = s
    if ch in s:
        sl = s.lstrip(ch)
        if len(sl) == 0:
            sl = sl + '!?'
    else:
        return 'no'
    return sl

def check(candidate):
    assert candidate('@@@ff', '@') == 'ff'

def test_check():
    check(f)

test_check()
