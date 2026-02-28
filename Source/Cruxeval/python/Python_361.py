def f(text: str) -> int:    
    return text.split(':')[0].count('#')

def check(candidate):
    assert candidate('#! : #!') == 1

def test_check():
    check(f)

test_check()
