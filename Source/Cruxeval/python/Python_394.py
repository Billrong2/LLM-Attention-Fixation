def f(text: str) -> int:    
    k = text.splitlines()
    i = 0
    for j in k:
        if len(j) == 0:
            return i
        i+=1
    return -1

def check(candidate):
    assert candidate('2 m2 \n\nbike') == 1

def test_check():
    check(f)

test_check()
