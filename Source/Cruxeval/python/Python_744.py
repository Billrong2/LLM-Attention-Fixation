def f(text: str, new_ending: str) -> str:    
    result = list(text)
    result.extend(new_ending)
    return ''.join(result)

def check(candidate):
    assert candidate('jro', 'wdlp') == 'jrowdlp'

def test_check():
    check(f)

test_check()
