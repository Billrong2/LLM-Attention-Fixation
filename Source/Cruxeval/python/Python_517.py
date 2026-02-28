def f(text: str) -> str:    
    for i in range(len(text)-1, 0, -1):
        if not text[i].isupper():
            return text[0:i]
    return ''

def check(candidate):
    assert candidate('SzHjifnzog') == 'SzHjifnzo'

def test_check():
    check(f)

test_check()
