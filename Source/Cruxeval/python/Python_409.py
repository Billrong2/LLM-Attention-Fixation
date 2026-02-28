def f(text: str, char: str) -> str:    
    if text:
        text = text.removeprefix(char)
        text = text.removeprefix(text[-1])
        text = text[:-1] + text[-1].capitalize()
    return text

def check(candidate):
    assert candidate('querist', 'u') == 'querisT'

def test_check():
    check(f)

test_check()
