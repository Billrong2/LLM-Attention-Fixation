import string

def f(text: str) -> str:    
    if text and text.isupper():
        cs = str.maketrans(string.ascii_uppercase, string.ascii_lowercase)
        return text.translate(cs)
    return text.lower()[:3]

def check(candidate):
    assert candidate('mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n') == 'mty'

def test_check():
    check(f)

test_check()
