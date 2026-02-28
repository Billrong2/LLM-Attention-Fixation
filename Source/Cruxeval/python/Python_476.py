def f(a: str, split_on: str) -> bool:    
    t = a.split()
    a = []
    for i in t:
        for j in i:
            a.append(j)
    if split_on in a:
        return True
    else:
        return False

def check(candidate):
    assert candidate('booty boot-boot bootclass', 'k') == False

def test_check():
    check(f)

test_check()
