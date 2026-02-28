def f(replace: str, text: str, hide: str) -> str:    
    while hide in text:
        replace += 'ax'
        text = text.replace(hide, replace, 1)
    return text

def check(candidate):
    assert candidate('###', 'ph>t#A#BiEcDefW#ON#iiNCU', '.') == 'ph>t#A#BiEcDefW#ON#iiNCU'

def test_check():
    check(f)

test_check()
