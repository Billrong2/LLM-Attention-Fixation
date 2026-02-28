def f(string: str) -> str:    
    return string.replace('needles', 'haystacks')

def check(candidate):
    assert candidate('wdeejjjzsjsjjsxjjneddaddddddefsfd') == 'wdeejjjzsjsjjsxjjneddaddddddefsfd'

def test_check():
    check(f)

test_check()
