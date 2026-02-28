def f(input_string: str, spaces: int) -> str:    
    return input_string.expandtabs(spaces)

def check(candidate):
    assert candidate('a\\tb', 4) == 'a\\tb'

def test_check():
    check(f)

test_check()
