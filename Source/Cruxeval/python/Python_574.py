from typing import List

def f(simpons: List[str]) -> str:    
    while simpons:
        pop = simpons.pop()
        if pop == pop.title():
            return pop
    return pop

def check(candidate):
    assert candidate(['George', 'Michael', 'George', 'Costanza']) == 'Costanza'

def test_check():
    check(f)

test_check()
