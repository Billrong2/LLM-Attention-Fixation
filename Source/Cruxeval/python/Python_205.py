def f(a: str) -> str:    
    for _ in range(10):
        for j in range(len(a)):
            if a[j] != '#':
                a = a[j:]
                break
        else:
            a = ""
            break
    while a[-1] == '#':
        a = a[:-1]
    return a

def check(candidate):
    assert candidate('##fiu##nk#he###wumun##') == 'fiu##nk#he###wumun'

def test_check():
    check(f)

test_check()
