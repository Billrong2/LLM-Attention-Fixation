def f(text: str) -> str:    
    (k, l) = (0, len(text) - 1)
    while not text[l].isalpha():
        l -= 1
    while not text[k].isalpha():
        k += 1
    if k != 0 or l != len(text) - 1:
        return text[k: l+1]
    else:
        return text[0]

def check(candidate):
    assert candidate('timetable, 2mil') == 't'

def test_check():
    check(f)

test_check()
