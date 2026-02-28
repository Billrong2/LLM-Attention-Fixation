def f(text: str, new_value: str, index: int) -> str:    
    key = text.maketrans(text[index], new_value)
    return text.translate(key)

def check(candidate):
    assert candidate('spain', 'b', 4) == 'spaib'

def test_check():
    check(f)

test_check()
