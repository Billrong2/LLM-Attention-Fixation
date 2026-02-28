from typing import List

def f(strands: List[str]) -> str:    
    subs = strands
    for i, j in enumerate(subs):
        for _ in range(len(j) // 2):
            subs[i] = subs[i][-1:] + subs[i][1:-1] + subs[i][0]
    return ''.join(subs)

def check(candidate):
    assert candidate(['__', '1', '.', '0', 'r0', '__', 'a_j', '6', '__', '6']) == '__1.00r__j_a6__6'

def test_check():
    check(f)

test_check()
