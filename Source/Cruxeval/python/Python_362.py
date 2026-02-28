def f(text: str) -> str:    
    for i in range(len(text)-1):
        if text[i:].islower():
            return text[i + 1:]
    return ''

def check(candidate):
    assert candidate('wrazugizoernmgzu') == 'razugizoernmgzu'

def test_check():
    check(f)

test_check()
