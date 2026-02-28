def f(text: str) -> bool:    
    if text == '':
        return False
    first_char = text[0]
    if text[0].isdigit():
        return False
    for last_char in text:
        if (last_char != '_') and not last_char.isidentifier():
            return False
    return True

def check(candidate):
    assert candidate('meet') == True

def test_check():
    check(f)

test_check()
