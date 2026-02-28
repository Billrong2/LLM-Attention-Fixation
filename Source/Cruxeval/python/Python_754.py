from typing import List

def f(nums: List[str]) -> List[str]:    
    nums = ['{0:{fill}>{width}}'.format(val, **{'fill': '0', 'width': nums[0]}) for val in nums[1:]]
    return [str(val) for val in nums]

def check(candidate):
    assert candidate(['1', '2', '2', '44', '0', '7', '20257']) == ['2', '2', '44', '0', '7', '20257']

def test_check():
    check(f)

test_check()
