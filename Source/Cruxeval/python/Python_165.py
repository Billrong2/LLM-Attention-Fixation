def f(text: str, lower: int, upper: int) -> bool:    
    return text[lower:upper].isascii()

def check(candidate):
    assert candidate('=xtanp|sugv?z', 3, 6) == True

def test_check():
    check(f)

test_check()
