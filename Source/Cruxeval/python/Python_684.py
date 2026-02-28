def f(text: str) -> str:    
    trans = str.maketrans('"\'><', '9833')
    return text.translate(trans)

def check(candidate):
    assert candidate('Transform quotations"\nnot into numbers.') == 'Transform quotations9\nnot into numbers.'

def test_check():
    check(f)

test_check()
