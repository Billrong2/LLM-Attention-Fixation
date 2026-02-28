from typing import List, Any

def f(container: List[int], cron: int) -> List[int]:    
    if not cron in container:
        return container
    pref = container[:container.index(cron)].copy()
    suff = container[container.index(cron) + 1:].copy()
    return pref + suff

def check(candidate):
    assert candidate([], 2) == []

def test_check():
    check(f)

test_check()
