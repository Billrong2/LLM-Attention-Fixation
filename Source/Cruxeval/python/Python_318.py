def f(value: str, char: str) -> int:    
    total = 0
    for c in value:
        if c == char or c == char.lower():
            total += 1
    return total

def check(candidate):
    assert candidate('234rtccde', 'e') == 1

def test_check():
    check(f)

test_check()
