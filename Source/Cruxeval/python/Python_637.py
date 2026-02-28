def f(text: str) -> str:    
    text = text.split(' ')
    for t in text:
        if not t.isnumeric():
            return 'no'
    return 'yes'

def check(candidate):
    assert candidate('03625163633 d') == 'no'

def test_check():
    check(f)

test_check()
