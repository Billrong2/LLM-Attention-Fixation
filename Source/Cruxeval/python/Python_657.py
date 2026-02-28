def f(text: str) -> str:    
    for punct in '!.?,:;':
        if text.count(punct) > 1:
            return 'no'
        if text.endswith(punct):
            return 'no'
    return text.title()

def check(candidate):
    assert candidate('djhasghasgdha') == 'Djhasghasgdha'

def test_check():
    check(f)

test_check()
