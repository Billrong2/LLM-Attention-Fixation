def f(text: str) -> int:    
    result_list = ['3', '3', '3', '3']
    if result_list:
        result_list.clear()
    return len(text)

def check(candidate):
    assert candidate('mrq7y') == 5

def test_check():
    check(f)

test_check()
