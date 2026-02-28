def f(txt: str, sep: str, sep_count: int) -> str:    
    o = ''
    while sep_count > 0 and txt.count(sep) > 0:
        o += txt.rsplit(sep, 1)[0] + sep
        txt = txt.rsplit(sep, 1)[1]
        sep_count -= 1
    return o + txt

def check(candidate):
    assert candidate('i like you', ' ', -1) == 'i like you'

def test_check():
    check(f)

test_check()
