def f(sentences: str) -> str:    
    if all([sentence.isdecimal() for sentence in sentences.split('.')]):
        return 'oscillating' 
    else:
        return 'not oscillating'

def check(candidate):
    assert candidate('not numbers') == 'not oscillating'

def test_check():
    check(f)

test_check()
