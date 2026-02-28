def f(text: str) -> str:    
    a = text.strip().split(' ')
    for i in range(len(a)):
        if a[i].isdigit() is False:
            return '-'
    return " ".join(a)

def check(candidate):
    assert candidate('d khqw whi fwi bbn 41') == '-'

def test_check():
    check(f)

test_check()
