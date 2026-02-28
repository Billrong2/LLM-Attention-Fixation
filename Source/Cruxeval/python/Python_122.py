def f(string: str) -> str:    
    if string[:4] != 'Nuva':
        return 'no'
    else:
        return string.rstrip()

def check(candidate):
    assert candidate('Nuva?dlfuyjys') == 'Nuva?dlfuyjys'

def test_check():
    check(f)

test_check()
