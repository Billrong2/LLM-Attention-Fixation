def f(text: str) -> int:    
    a = 0
    if text[0] in text[1:]:
        a += 1
    for i in range(0, len(text)-1):
        if text[i] in text[i+1:]:
            a += 1
    return a

def check(candidate):
    assert candidate('3eeeeeeoopppppppw14film3oee3') == 18

def test_check():
    check(f)

test_check()
