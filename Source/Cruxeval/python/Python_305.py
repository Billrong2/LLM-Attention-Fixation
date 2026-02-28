def f(text: str, char: str) -> str:    
    length = len(text)
    index = -1
    for i in range(length):
        if text[i] == char:
            index = i
    if index == -1:
        index = length // 2
    new_text = list(text)
    new_text.pop(index)
    return ''.join(new_text)

def check(candidate):
    assert candidate('o horseto', 'r') == 'o hoseto'

def test_check():
    check(f)

test_check()
