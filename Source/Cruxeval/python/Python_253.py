def f(text: str, pref: str) -> str:    
    length = len(pref)
    if pref == text[:length]:
        return text[length:]
    return text

def check(candidate):
    assert candidate('kumwwfv', 'k') == 'umwwfv'

def test_check():
    check(f)

test_check()
