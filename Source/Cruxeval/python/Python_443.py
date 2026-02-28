def f(text: str) -> str:    
    for space in text:
        if space == ' ':
            text = text.lstrip()
        else:
            text = text.replace('cd', space)
    return text

def check(candidate):
    assert candidate('lorem ipsum') == 'lorem ipsum'

def test_check():
    check(f)

test_check()
