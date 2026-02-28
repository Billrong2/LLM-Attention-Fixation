def f(name: str) -> str:    
    if name.islower():
        name = name.upper()
    else:
        name = name.lower()
    return name

def check(candidate):
    assert candidate('Pinneaple') == 'pinneaple'

def test_check():
    check(f)

test_check()
