def f(text: str) -> str:    
    if text.isalnum() and all(i.isdigit() for i in text):
        return 'integer'
    return 'string'

def check(candidate):
    assert candidate('') == 'string'

def test_check():
    check(f)

test_check()
