def f(text: str) -> str:    
    index = 1
    while index < len(text):
        if text[index] != text[index - 1]:
            index += 1
        else:
            text1 = text[:index]
            text2 = text[index:].swapcase()
            return text1 + text2
    return text.swapcase()

def check(candidate):
    assert candidate('USaR') == 'usAr'

def test_check():
    check(f)

test_check()
