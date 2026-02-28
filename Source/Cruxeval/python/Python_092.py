def f(text: str) -> bool:    
    return text.isascii()

def check(candidate):
    assert candidate('wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct') == False

def test_check():
    check(f)

test_check()
