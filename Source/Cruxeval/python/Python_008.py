def f(string: str, encryption: int) -> str:    
    if encryption == 0:
        return string
    else:
        return string.upper().encode('rot13')

def check(candidate):
    assert candidate('UppEr', 0) == 'UppEr'

def test_check():
    check(f)

test_check()
