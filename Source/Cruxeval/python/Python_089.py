def f(char: str) -> str:    
    if char not in 'aeiouAEIOU':
        return None
    if char in 'AEIOU':
        return char.lower()
    return char.upper()

def check(candidate):
    assert candidate('o') == 'O'

def test_check():
    check(f)

test_check()
