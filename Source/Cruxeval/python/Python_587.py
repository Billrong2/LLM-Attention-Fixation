from typing import List, Any, Dict

def f(nums: List[int], fill: str) -> Dict[int, str]:    
    ans = dict.fromkeys(nums, fill)
    return ans

def check(candidate):
    assert candidate([0, 1, 1, 2], 'abcca') == { 0: 'abcca', 1: 'abcca', 2: 'abcca' }

def test_check():
    check(f)

test_check()
