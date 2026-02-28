def f(text: str, c: str) -> str:    
    ls = list(text)
    if c not in text:
        raise ValueError('Text has no {c}')
    ls.pop(text.rindex(c))
    return ''.join(ls)

def check(candidate):
    assert candidate('uufhl', 'l') == 'uufh'

def test_check():
    check(f)

test_check()
