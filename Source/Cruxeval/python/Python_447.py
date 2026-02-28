def f(text: str, tab_size: int) -> str:    
    res = ''
    text = text.replace('\t', ' '*(tab_size-1))
    for i in range(len(text)):
        if text[i] == ' ':
            res += '|'
        else:
            res += text[i]
    return res

def check(candidate):
    assert candidate('\ta', 3) == '||a'

def test_check():
    check(f)

test_check()
