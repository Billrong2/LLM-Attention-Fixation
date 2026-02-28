def f(text: str) -> int:    
    number = 0
    for t in text:
        if t.isnumeric():
            number += 1
    return number

def check(candidate):
    assert candidate('Thisisastring') == 0

def test_check():
    check(f)

test_check()
