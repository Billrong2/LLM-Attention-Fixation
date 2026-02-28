def f(text: str) -> str:    
    return ', '.join(text.splitlines())

def check(candidate):
    assert candidate('BYE\nNO\nWAY') == 'BYE, NO, WAY'

def test_check():
    check(f)

test_check()
