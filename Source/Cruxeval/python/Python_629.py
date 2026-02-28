def f(text: str, dng: str) -> str:    
    if dng not in text:
        return text
    if text[-len(dng):] == dng:
        return text[:-len(dng)]
    return text[:-1] + f(text[:-2], dng)

def check(candidate):
    assert candidate('catNG', 'NG') == 'cat'

def test_check():
    check(f)

test_check()
