def f(input: str) -> bool:    
    for char in input:
        if char.isupper():
            return False
    return True

def check(candidate):
    assert candidate('a j c n x X k') == False

def test_check():
    check(f)

test_check()
