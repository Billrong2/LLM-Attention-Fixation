def f(text: str, width: int) -> str:    
    return text[:width].center(width, 'z')

def check(candidate):
    assert candidate('0574', 9) == 'zzz0574zz'

def test_check():
    check(f)

test_check()
