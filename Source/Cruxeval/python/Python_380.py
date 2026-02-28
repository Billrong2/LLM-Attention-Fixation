def f(text: str, delimiter: str) -> str:    
    text = text.rpartition(delimiter)
    return text[0] + text[-1]

def check(candidate):
    assert candidate('xxjarczx', 'x') == 'xxjarcz'

def test_check():
    check(f)

test_check()
