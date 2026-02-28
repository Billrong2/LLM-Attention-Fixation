def f(text: str, suffix: str, num: int) -> bool:    
    str_num = str(num)
    return text.endswith(suffix + str_num)

def check(candidate):
    assert candidate('friends and love', 'and', 3) == False

def test_check():
    check(f)

test_check()
