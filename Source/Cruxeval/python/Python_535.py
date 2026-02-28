def f(n: int) -> bool:    
    for n in str(n):
        if n not in "012" and n not in list(range(5, 10)):
            return False
    return True

def check(candidate):
    assert candidate(1341240312) == False

def test_check():
    check(f)

test_check()
