from typing import List

def f(ints: List[int]) -> str:    
    counts = [0] * 301

    for i in ints:
        counts[i] += 1

    r = []
    for i in range(len(counts)):
        if counts[i] >= 3:
            r.append(str(i))
    counts.clear()
    return ' '.join(r)

def check(candidate):
    assert candidate([2, 3, 5, 2, 4, 5, 2, 89]) == '2'

def test_check():
    check(f)

test_check()
