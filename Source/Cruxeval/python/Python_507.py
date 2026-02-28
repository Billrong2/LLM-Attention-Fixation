def f(text: str, search: str) -> int:    
    result = text.lower()
    return result.find(search.lower())

def check(candidate):
    assert candidate('car hat', 'car') == 0

def test_check():
    check(f)

test_check()
