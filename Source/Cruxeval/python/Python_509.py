def f(value: int, width: int) -> str:    
    if value >= 0:
        return str(value).zfill(width)

    if value < 0:
        return '-' + str(-value).zfill(width)
    return ''

def check(candidate):
    assert candidate(5, 1) == '5'

def test_check():
    check(f)

test_check()
