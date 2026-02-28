def f(text: str) -> int:
    a = len(text)
    count = 0
    while text:
        if text.startswith('a'):
            count += text.find(' ')
        else:
            count += text.find('\n')
        text = text[text.find('\n')+1:text.find('\n')+a+1]
    return count

def check(candidate):
    assert candidate('a\nkgf\nasd\n') == 1

def test_check():
    check(f)

test_check()
