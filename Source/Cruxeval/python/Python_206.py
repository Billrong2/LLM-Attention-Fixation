def f(a: str) -> str:    
    return ' '.join(a.split())

def check(candidate):
    assert candidate(' h e l l o   w o r l d! ') == 'h e l l o w o r l d!'

def test_check():
    check(f)

test_check()
