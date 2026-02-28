def f(text: str, prefix: str) -> str:    
    idx = 0
    for letter in prefix:
        if text[idx] != letter:
            return None
        idx += 1
    return text[idx:]

def check(candidate):
    assert candidate('bestest', 'bestest') == ''

def test_check():
    check(f)

test_check()
