def f(text: str, value: str) -> int:    
    if isinstance(value, str):
        return text.count(value) + text.count(value.lower())
    return text.count(value)

def check(candidate):
    assert candidate('eftw{ьТсk_1', '\\') == 0

def test_check():
    check(f)

test_check()
