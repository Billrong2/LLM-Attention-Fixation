def f(text: str) -> int:    
    text = text.upper()
    count_upper = 0
    for char in text:
        if char.isupper():
            count_upper += 1
        else:
            return 'no'
    return count_upper // 2

def check(candidate):
    assert candidate('ax') == 1

def test_check():
    check(f)

test_check()
