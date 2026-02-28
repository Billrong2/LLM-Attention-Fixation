def f(text: str) -> bool:    
    length = len(text)
    half = length // 2
    encode = text[:half].encode('ascii')
    if text[half:] == encode.decode():
        return True
    else:
        return False

def check(candidate):
    assert candidate('bbbbr') == False

def test_check():
    check(f)

test_check()
