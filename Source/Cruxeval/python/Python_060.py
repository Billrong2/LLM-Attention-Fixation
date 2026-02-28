def f(doc: str) -> str:    
    for x in doc:
        if x.isalpha():
            return x.capitalize()
    return '-'

def check(candidate):
    assert candidate('raruwa') == 'R'

def test_check():
    check(f)

test_check()
