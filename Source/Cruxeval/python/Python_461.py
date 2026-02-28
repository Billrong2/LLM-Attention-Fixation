def f(text: str, search: str) -> bool:    
    return search.startswith(text) or False

def check(candidate):
    assert candidate('123', '123eenhas0') == True

def test_check():
    check(f)

test_check()
