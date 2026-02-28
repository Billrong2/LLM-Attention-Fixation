def f(text: str, strip_chars: str) -> str:    
    return text[::-1].strip(strip_chars)[::-1]

def check(candidate):
    assert candidate('tcmfsmj', 'cfj') == 'tcmfsm'

def test_check():
    check(f)

test_check()
