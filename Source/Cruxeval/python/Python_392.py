def f(text: str) -> str:    
    if text.upper() == text:
        return 'ALL UPPERCASE'
    return text

def check(candidate):
    assert candidate('Hello Is It MyClass') == 'Hello Is It MyClass'

def test_check():
    check(f)

test_check()
