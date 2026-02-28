def f(text: str) -> str:    
    return ' '.join(map(str.lstrip, text.split()))

def check(candidate):
    assert candidate('pvtso') == 'pvtso'

def test_check():
    check(f)

test_check()
