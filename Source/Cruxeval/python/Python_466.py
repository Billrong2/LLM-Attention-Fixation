def f(text: str) -> str:    
    length = len(text)
    index = 0
    while index < length and text[index].isspace():
        index += 1
    return text[index:index+5]

def check(candidate):
    assert candidate('-----\t\n\tth\n-----') == '-----'

def test_check():
    check(f)

test_check()
