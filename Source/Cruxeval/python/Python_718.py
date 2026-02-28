def f(text: str) -> str:    
    t = text
    for i in text:
        text = text.replace(i, '')
    return str(len(text)) + t

def check(candidate):
    assert candidate('ThisIsSoAtrocious') == '0ThisIsSoAtrocious'

def test_check():
    check(f)

test_check()
