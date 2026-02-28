def f(numbers: str) -> int:    
    for i in range(len(numbers)):
        if numbers.count('3') > 1:
            return i
    return -1

def check(candidate):
    assert candidate('23157') == -1

def test_check():
    check(f)

test_check()
