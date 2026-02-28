def f(text: str) -> int:    
    return max(text.find(ch) for ch in 'aeiou')

def check(candidate):
    assert candidate('qsqgijwmmhbchoj') == 13

def test_check():
    check(f)

test_check()
