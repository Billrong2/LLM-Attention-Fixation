def f(text: str) -> str:    
    letters = ''
    for i in range(len(text)):
        if text[i].isalnum():
            letters += text[i]
    return letters

def check(candidate):
    assert candidate('we@32r71g72ug94=(823658*!@324') == 'we32r71g72ug94823658324'

def test_check():
    check(f)

test_check()
