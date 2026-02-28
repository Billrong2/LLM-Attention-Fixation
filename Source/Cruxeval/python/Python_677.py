def f(text: str, length: int) -> str:    
    length = -length if length < 0 else length
    output = ''
    for idx in range(length):
        if text[idx % len(text)] != ' ':
            output += text[idx % len(text)]
        else:
            break
    return output

def check(candidate):
    assert candidate('I got 1 and 0.', 5) == 'I'

def test_check():
    check(f)

test_check()
