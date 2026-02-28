def f(text: str) -> str:    
    if ',' in text:
        before, _, after = text.partition(',')
        return after + ' ' + before
    return ',' + text.partition(' ')[-1] + ' 0'

def check(candidate):
    assert candidate('244, 105, -90') == ' 105, -90 244'

def test_check():
    check(f)

test_check()
