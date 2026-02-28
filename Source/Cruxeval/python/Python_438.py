def f(string: str) -> str:    
    bigTab = 100
    for i in range(10, 30):
        if 0 < string.count('\t') < 20:
            bigTab = i
            break
    return string.expandtabs(bigTab)

def check(candidate):
    assert candidate('1  \t\t\t3') == '1                             3'

def test_check():
    check(f)

test_check()
