def f(text: str) -> bool:    
    for i in range(len(text)):
        if text[i] == text[i].upper() and text[i-1].islower():
            return True
    return False

def check(candidate):
    assert candidate('jh54kkk6') == True

def test_check():
    check(f)

test_check()
