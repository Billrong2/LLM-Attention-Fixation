def f(text: str, suffix: str) -> str:    
    text += suffix
    while text[-len(suffix):] == suffix:
        text = text[:-1]
    return text

def check(candidate):
    assert candidate('faqo osax f', 'f') == 'faqo osax '

def test_check():
    check(f)

test_check()
