def f(text: str, sub: str) -> int:    
    a = 0
    b = len(text) - 1

    while a <= b:
        c = (a + b) // 2
        if text.rfind(sub) >= c:
            a = c + 1
        else:
            b = c - 1

    return a

def check(candidate):
    assert candidate('dorfunctions', '2') == 0

def test_check():
    check(f)

test_check()
