def f(text: str, tabstop: int) -> str:    
    text = text.replace('\n', '_____')
    text = text.replace('\t', tabstop * ' ')
    text = text.replace('_____', '\n')
    return text

def check(candidate):
    assert candidate('odes\tcode\twell', 2) == 'odes  code  well'

def test_check():
    check(f)

test_check()
