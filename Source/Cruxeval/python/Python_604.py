def f(text: str, start: str) -> bool:    
    return text.startswith(start)

def check(candidate):
    assert candidate('Hello world', 'Hello') == True

def test_check():
    check(f)

test_check()
