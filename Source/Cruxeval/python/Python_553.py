def f(text: str, count: int) -> str:    
    for i in range(count):
        text = text[::-1]
    return text

def check(candidate):
    assert candidate('439m2670hlsw', 3) == 'wslh0762m934'

def test_check():
    check(f)

test_check()
