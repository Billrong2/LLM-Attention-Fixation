def f(text: str) -> int:    
    return text.find(",")

def check(candidate):
    assert candidate('There are, no, commas, in this text') == 9

def test_check():
    check(f)

test_check()
