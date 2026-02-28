def f(text: str, delim: str) -> str:    
    return text[:text[::-1].find(delim)][::-1]

def check(candidate):
    assert candidate('dsj osq wi w', ' ') == 'd'

def test_check():
    check(f)

test_check()
