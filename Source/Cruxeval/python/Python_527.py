def f(text: str, value: str) -> str:    
    return text.ljust(len(value), "?")

def check(candidate):
    assert candidate('!?', '') == '!?'

def test_check():
    check(f)

test_check()
