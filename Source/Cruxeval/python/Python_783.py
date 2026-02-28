def f(text: str, comparison: str) -> int:    
    length = len(comparison)
    if length <= len(text):
        for i in range(length):
            if comparison[length - i - 1] != text[len(text) - i - 1]:
                return i
    return length

def check(candidate):
    assert candidate('managed', '') == 0

def test_check():
    check(f)

test_check()
