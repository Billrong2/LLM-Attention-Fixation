def f(text: str, suffix: str) -> str:    
    if suffix and suffix[-1] in text:
        return f(text.rstrip(suffix[-1]), suffix[:-1])
    else:
        return text

def check(candidate):
    assert candidate('rpyttc', 'cyt') == 'rpytt'

def test_check():
    check(f)

test_check()
