def f(text: str) -> str:    
    text = text.lower()
    head, tail = text[0], text[1:]
    return head.upper() + tail

def check(candidate):
    assert candidate('Manolo') == 'Manolo'

def test_check():
    check(f)

test_check()
