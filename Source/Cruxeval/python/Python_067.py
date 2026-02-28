def f(num1: int, num2: int, num3: int) -> str:    
    nums = [num1, num2, num3]
    nums.sort()    
    return f'{nums[0]},{nums[1]},{nums[2]}'

def check(candidate):
    assert candidate(6, 8, 8) == '6,8,8'

def test_check():
    check(f)

test_check()
