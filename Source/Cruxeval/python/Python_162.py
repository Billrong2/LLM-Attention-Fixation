def f(text: str) -> str:    
    result = ''
    for char in text:
        if char.isalnum():
            result += char.upper()
    return result

def check(candidate):
    assert candidate('с bishop.Swift') == 'СBISHOPSWIFT'

def test_check():
    check(f)

test_check()
