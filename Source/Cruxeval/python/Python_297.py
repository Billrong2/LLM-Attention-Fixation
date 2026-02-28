def f(num: int) -> str:    
    if 0 < num < 1000 and num != 6174:
        return 'Half Life'
    return 'Not found'

def check(candidate):
    assert candidate(6173) == 'Not found'

def test_check():
    check(f)

test_check()
