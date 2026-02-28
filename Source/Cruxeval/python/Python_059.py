def f(s: str) -> str:    
    a = [char for char in s if char != ' ']
    b = a
    for c in reversed(a):
        if c == ' ':
            b.pop()
        else:
            break
    return ''.join(b)

def check(candidate):
    assert candidate('hi ') == 'hi'

def test_check():
    check(f)

test_check()
