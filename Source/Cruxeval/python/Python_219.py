def f(s1: str, s2: str) -> bool:    
    for k in range(0, len(s2)+len(s1)):
        s1 += s1[0]
        if s1.find(s2) >= 0:
            return True
    return False

def check(candidate):
    assert candidate('Hello', ')') == False

def test_check():
    check(f)

test_check()
