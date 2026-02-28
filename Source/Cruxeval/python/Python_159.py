def f(st: str) -> str:    
    swapped = ''
    for ch in reversed(st):
        swapped += ch.swapcase()
    return swapped

def check(candidate):
    assert candidate('RTiGM') == 'mgItr'

def test_check():
    check(f)

test_check()
