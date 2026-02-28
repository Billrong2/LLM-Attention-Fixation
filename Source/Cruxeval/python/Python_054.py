def f(text: str, s: int, e: int) -> int:    
    sublist = text[s:e]
    if not sublist:
        return -1
    return sublist.index(min(sublist))

def check(candidate):
    assert candidate('happy', 0, 3) == 1

def test_check():
    check(f)

test_check()
