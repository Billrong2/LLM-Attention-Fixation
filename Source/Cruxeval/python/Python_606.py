def f(value: str) -> str:    
    ls = list(value)
    ls.append('NHIB')
    return ''.join(ls)

def check(candidate):
    assert candidate('ruam') == 'ruamNHIB'

def test_check():
    check(f)

test_check()
