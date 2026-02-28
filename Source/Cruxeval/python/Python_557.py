def f(s: str) -> str:
    d = s.rpartition('ar')
    return ' '.join((d[0], d[1], d[2]))

def check(candidate):
    assert candidate('xxxarmmarxx') == 'xxxarmm ar xx'

def test_check():
    check(f)

test_check()
