def f(text: str, char: str) -> str:    
    index = text.rindex(char)
    result = list(text)
    while index > 0:
        result[index] = result[index-1]
        result[index-1] = char
        index -= 2
    return ''.join(result)

def check(candidate):
    assert candidate('qpfi jzm', 'j') == 'jqjfj zm'

def test_check():
    check(f)

test_check()
