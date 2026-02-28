def f(text: str) -> str:    
    count = text.count(text[0])
    ls = list(text)
    for _ in range(count):
        ls.remove(ls[0])
    return ''.join(ls)

def check(candidate):
    assert candidate(';,,,?') == ',,,?'

def test_check():
    check(f)

test_check()
