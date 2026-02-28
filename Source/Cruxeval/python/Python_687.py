def f(text: str) -> str:    
    t = list(text)
    t.pop(len(t) // 2)
    t.append(text.lower())
    return ':'.join([c for c in t])

def check(candidate):
    assert candidate('Rjug nzufE') == 'R:j:u:g: :z:u:f:E:rjug nzufe'

def test_check():
    check(f)

test_check()
