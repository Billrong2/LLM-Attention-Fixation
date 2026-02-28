def f(text: str) -> str:    
    text = text.lower()
    capitalize = text.capitalize()
    return text[:1] + capitalize[1:]

def check(candidate):
    assert candidate('this And cPanel') == 'this and cpanel'

def test_check():
    check(f)

test_check()
