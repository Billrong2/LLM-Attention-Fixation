from typing import List, Dict

def f(arr: List[str], d: Dict[str, str]) -> Dict[str, str]:    
    for i in range(1, len(arr), 2):
        d.update({arr[i]: arr[i-1]})

    return d

def check(candidate):
    assert candidate(['b', 'vzjmc', 'f', 'ae', '0'], {  }) == { 'vzjmc': 'b', 'ae': 'f' }

def test_check():
    check(f)

test_check()
