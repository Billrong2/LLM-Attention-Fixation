def f(name: str) -> str:    
    return '*'.join(name.split(' '))

def check(candidate):
    assert candidate('Fred Smith') == 'Fred*Smith'

def test_check():
    check(f)

test_check()
