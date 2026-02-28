def f(text: str) -> str:    
    s = text.lower()
    for i in range(len(s)):
        if s[i] == 'x':
            return 'no'
    return text.isupper()

def check(candidate):
    assert candidate('dEXE') == 'no'

def test_check():
    check(f)

test_check()
