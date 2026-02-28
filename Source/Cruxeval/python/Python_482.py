def f(text: str) -> str:    
    return text.replace('\\"', '"')

def check(candidate):
    assert candidate('Because it intrigues them') == 'Because it intrigues them'

def test_check():
    check(f)

test_check()
