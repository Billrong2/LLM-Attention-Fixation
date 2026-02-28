def f(text: str, letter: str) -> int:    
    t = text
    for alph in text:
        t = t.replace(alph, "")
    return len(t.split(letter))

def check(candidate):
    assert candidate('c, c, c ,c, c', 'c') == 1

def test_check():
    check(f)

test_check()
