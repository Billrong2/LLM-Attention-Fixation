def f(string: str) -> str:    
    while string:
        if string[-1].isalpha():
            return string
        string = string[:-1]
    return string

def check(candidate):
    assert candidate('--4/0-209') == ''

def test_check():
    check(f)

test_check()
