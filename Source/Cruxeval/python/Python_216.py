def f(letters: str) -> int:    
    count = 0
    for l in letters:
        if l.isdigit():
            count += 1
    return count

def check(candidate):
    assert candidate('dp ef1 gh2') == 2

def test_check():
    check(f)

test_check()
