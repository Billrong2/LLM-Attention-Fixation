def f(n: int) -> str:    
    streak = ''
    for c in str(n):
        streak += c.ljust(int(c) * 2)
    return streak

def check(candidate):
    assert candidate(1) == '1 '

def test_check():
    check(f)

test_check()
