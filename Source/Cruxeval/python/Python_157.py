def f(phrase: str) -> int:    
    ans = 0
    for w in phrase.split():
        for ch in w:
            if ch == "0":
                ans += 1
    return ans

def check(candidate):
    assert candidate('aboba 212 has 0 digits') == 1

def test_check():
    check(f)

test_check()
