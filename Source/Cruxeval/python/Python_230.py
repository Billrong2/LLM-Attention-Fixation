def f(text: str) -> str:    
    result = ''
    i = len(text)-1
    while i >= 0:
        c = text[i]
        if c.isalpha():
            result += c
        i -= 1
    return result

def check(candidate):
    assert candidate('102x0zoq') == 'qozx'

def test_check():
    check(f)

test_check()
