def f(text: str) -> bool:    
    return text.count('-') == len(text)

def check(candidate):
    assert candidate('---123-4') == False

def test_check():
    check(f)

test_check()
