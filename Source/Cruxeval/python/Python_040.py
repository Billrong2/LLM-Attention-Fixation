def f(text: str) -> str:    
    return text.ljust(len(text) + 1, "#")

def check(candidate):
    assert candidate('the cow goes moo') == 'the cow goes moo#'

def test_check():
    check(f)

test_check()
