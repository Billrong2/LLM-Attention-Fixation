def f(text: str) -> str:    
    for i in range(10, 0, -1):
        text = text.lstrip(str(i))
    return text

def check(candidate):
    assert candidate('25000   $') == '5000   $'

def test_check():
    check(f)

test_check()
