def f(text: str, prefix: str) -> str:    
    if text.startswith(prefix):
        return text.removeprefix(prefix)
    if prefix in text:
        return text.replace(prefix, '').strip()
    return text.upper()

def check(candidate):
    assert candidate('abixaaaily', 'al') == 'ABIXAAAILY'

def test_check():
    check(f)

test_check()
