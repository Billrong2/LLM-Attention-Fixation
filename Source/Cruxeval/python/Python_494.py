def f(num: str, l: int) -> str:    
    t = ""
    while l > len(num):
        t += '0'
        l -= 1
    return t + num

def check(candidate):
    assert candidate('1', 3) == '001'

def test_check():
    check(f)

test_check()
