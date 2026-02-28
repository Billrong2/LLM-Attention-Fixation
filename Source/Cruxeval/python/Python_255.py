def f(text: str, fill: str, size: int) -> str:    
    if size < 0:
        size = -size
    if len(text) > size:
        return text[len(text) - size:]
    return text.rjust(size, fill)

def check(candidate):
    assert candidate('no asw', 'j', 1) == 'w'

def test_check():
    check(f)

test_check()
