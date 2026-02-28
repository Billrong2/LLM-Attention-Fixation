def f(text: str, symbols: str) -> str:    
    count = 0
    if symbols:
        for i in symbols:
            count += 1
        text = text * count
    return text.rjust(len(text) + count*2)[:-2]

def check(candidate):
    assert candidate('', 'BC1ty') == '        '

def test_check():
    check(f)

test_check()
