def f(text: str) -> bool:    
    return text.upper() == str(text)

def check(candidate):
    assert candidate('VTBAEPJSLGAHINS') == True

def test_check():
    check(f)

test_check()
