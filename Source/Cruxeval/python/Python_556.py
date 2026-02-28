def f(text: str) -> str:    
    for i in range(len(text)):
        if text[i] == ' ':
            text = text.replace(' ', '\t', 1)
    return text.expandtabs(4)

def check(candidate):
    assert candidate('\n\n\t\tz\td\ng\n\t\t\te') == '\n\n        z   d\ng\n            e'

def test_check():
    check(f)

test_check()
