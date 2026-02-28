def f(text: str, speaker: str) -> str:    
    while text.startswith(speaker):
        text = text[len(speaker):]
    return text

def check(candidate):
    assert candidate('[CHARRUNNERS]Do you know who the other was? [NEGMENDS]', '[CHARRUNNERS]') == 'Do you know who the other was? [NEGMENDS]'

def test_check():
    check(f)

test_check()
