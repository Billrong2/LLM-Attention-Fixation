def f(s: str) -> str:    
    count = len(s) - 1
    reverse_s = s[::-1]
    while count > 0 and reverse_s[::2].rfind('sea') == -1:
        count -= 1
        reverse_s = reverse_s[:count]
    return reverse_s[count:]

def check(candidate):
    assert candidate('s a a b s d s a a s a a') == ''

def test_check():
    check(f)

test_check()
