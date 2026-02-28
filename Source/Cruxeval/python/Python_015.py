def f(text: str, wrong: str, right: str) -> str:    
    new_text = text.replace(wrong, right)
    return new_text.upper()

def check(candidate):
    assert candidate('zn kgd jw lnt', 'h', 'u') == 'ZN KGD JW LNT'

def test_check():
    check(f)

test_check()
