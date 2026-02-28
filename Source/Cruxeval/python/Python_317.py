def f(text: str, a: str, b: str) -> str:    
    text = text.replace(a, b)
    return text.replace(b, a)

def check(candidate):
    assert candidate(' vup a zwwo oihee amuwuuw! ', 'a', 'u') == ' vap a zwwo oihee amawaaw! '

def test_check():
    check(f)

test_check()
