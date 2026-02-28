def f(text: str) -> str:    
    text = text.replace('#', '1').replace('$', '5')
    return 'yes' if text.isnumeric() else 'no'

def check(candidate):
    assert candidate('A') == 'no'

def test_check():
    check(f)

test_check()
