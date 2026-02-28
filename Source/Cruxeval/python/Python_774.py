def f(num: int, name: str) -> str:    
    f_str = 'quiz leader = {}, count = {}'
    return f_str.format(name, num)

def check(candidate):
    assert candidate(23, 'Cornareti') == 'quiz leader = Cornareti, count = 23'

def test_check():
    check(f)

test_check()
