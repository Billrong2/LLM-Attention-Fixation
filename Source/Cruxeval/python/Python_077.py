def f(text: str, character: str) -> str:    
    subject = text[text.rfind(character):]
    return subject*text.count(character)

def check(candidate):
    assert candidate('h ,lpvvkohh,u', 'i') == ''

def test_check():
    check(f)

test_check()
