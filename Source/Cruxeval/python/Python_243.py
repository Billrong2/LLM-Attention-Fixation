def f(text: str, char: str) -> bool:    
    return char.islower() and text.islower()

def check(candidate):
    assert candidate('abc', 'e') == True

def test_check():
    check(f)

test_check()
