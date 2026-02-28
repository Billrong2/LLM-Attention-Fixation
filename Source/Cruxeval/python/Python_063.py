def f(text: str, prefix: str) -> str:    
    while text.startswith(prefix):
        text = text[len(prefix):] or text
    return text

def check(candidate):
    assert candidate('ndbtdabdahesyehu', 'n') == 'dbtdabdahesyehu'

def test_check():
    check(f)

test_check()
