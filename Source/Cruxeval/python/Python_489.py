def f(text: str, value: str) -> str:    
    return text.removeprefix(value.lower())

def check(candidate):
    assert candidate('coscifysu', 'cos') == 'cifysu'

def test_check():
    check(f)

test_check()
