def f(text: str, changes: str) -> str:    
    result = ''
    count = 0
    changes = list(changes)
    for char in text:
        result += char if char in 'e' else changes[count % len(changes)]
        count += (1 if char not in 'e' else 0)
    return result

def check(candidate):
    assert candidate('fssnvd', 'yes') == 'yesyes'

def test_check():
    check(f)

test_check()
