def f(phrase: str) -> str:    
    result = ''
    for i in phrase:
        if not i.islower():
            result += i
    return result

def check(candidate):
    assert candidate('serjgpoDFdbcA.') == 'DFA.'

def test_check():
    check(f)

test_check()
