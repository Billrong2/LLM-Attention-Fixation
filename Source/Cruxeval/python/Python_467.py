from typing import Dict, List

def f(nums: Dict[str, str]) -> Dict[str, int]:    
    copy = nums.copy()
    newDict = dict()
    for k in copy:
        newDict[k] = len(copy[k])
    return newDict

def check(candidate):
    assert candidate({  }) == {  }

def test_check():
    check(f)

test_check()
