def f(text: str) -> bool:    
    try:
        return text.isalpha()
    except:
        return False

def check(candidate):
    assert candidate('x') == True

def test_check():
    check(f)

test_check()
