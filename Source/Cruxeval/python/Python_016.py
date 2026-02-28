def f(text: str, suffix: str) -> str:    
    if text.endswith(suffix):
        return text[:-len(suffix)]
    return text

def check(candidate):
    assert candidate('zejrohaj', 'owc') == 'zejrohaj'

def test_check():
    check(f)

test_check()
