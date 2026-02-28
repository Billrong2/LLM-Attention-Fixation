def f(text: str) -> str:    
    if not text.istitle():
        return text.title()
    return text.lower()

def check(candidate):
    assert candidate('PermissioN is GRANTed') == 'Permission Is Granted'

def test_check():
    check(f)

test_check()
