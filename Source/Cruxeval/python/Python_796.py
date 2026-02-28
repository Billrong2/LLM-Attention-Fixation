def f(str: str, toget: str) -> str:    
    if str.startswith(toget): return str[len(toget):]
    else: return str

def check(candidate):
    assert candidate('fnuiyh', 'ni') == 'fnuiyh'

def test_check():
    check(f)

test_check()
