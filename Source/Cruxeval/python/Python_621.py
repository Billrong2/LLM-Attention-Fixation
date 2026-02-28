def f(text: str, encoding: str) -> str:    
    try:
        return str(text.encode(encoding))
    except LookupError:
        return str(LookupError)

def check(candidate):
    assert candidate('13:45:56', 'shift_jis') == "b'13:45:56'"

def test_check():
    check(f)

test_check()
