def f(text: str, insert: str) -> str:    
    whitespaces = {'\t', '\r', '\v', ' ', '\f', '\n'}
    clean = ''
    for char in text:
        if char in whitespaces:
            clean += insert
        else:
            clean += char
    return clean

def check(candidate):
    assert candidate('pi wa', 'chi') == 'pichiwa'

def test_check():
    check(f)

test_check()
