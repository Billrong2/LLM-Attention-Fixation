from typing import Dict

def f(query: str, base: Dict[str, int]) -> int:    
    net_sum = 0
    for (key, val) in base.items():
        if key[0] == query and len(key) == 3:
            net_sum -= val
        elif key[-1] == query and len(key) == 3:
            net_sum += val
    return net_sum

def check(candidate):
    assert candidate('a', {  }) == 0

def test_check():
    check(f)

test_check()
