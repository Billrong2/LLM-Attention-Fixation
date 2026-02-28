def f(text: str, tab_size: int) -> str:    
    return text.replace('\t', ' '*tab_size)

def check(candidate):
    assert candidate('a', 100) == 'a'

def test_check():
    check(f)

test_check()
