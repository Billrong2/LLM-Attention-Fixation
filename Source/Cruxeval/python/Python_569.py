def f(txt: str) -> int:    
    coincidences = {}
    for c in txt:
        if c in coincidences:
            coincidences[c] += 1
        else:
            coincidences[c] = 1
    return sum(coincidences.values())

def check(candidate):
    assert candidate('11 1 1') == 6

def test_check():
    check(f)

test_check()
