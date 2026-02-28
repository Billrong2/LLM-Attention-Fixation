def f(name: str) -> str:    
    return '| ' + ' '.join(name.split(' ')) + ' |'

def check(candidate):
    assert candidate('i am your father') == '| i am your father |'

def test_check():
    check(f)

test_check()
