def f(s: str) -> str:    
    arr = list(s.strip())
    arr.reverse()
    return ''.join(arr)

def check(candidate):
    assert candidate('   OOP   ') == 'POO'

def test_check():
    check(f)

test_check()
