def f(text: str) -> str:    
    new_text = text
    while len(text) > 1 and text[0] == text[-1]:
        new_text = text = text[1:-1]
    return new_text

def check(candidate):
    assert candidate(')') == ')'

def test_check():
    check(f)

test_check()
