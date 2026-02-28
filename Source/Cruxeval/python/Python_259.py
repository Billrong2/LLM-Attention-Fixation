def f(text: str) -> str:    
    new_text = []
    for character in text:
        if character.isupper():
            new_text.insert(len(new_text) // 2, character)
    if len(new_text) == 0:
        new_text = ['-']
    return ''.join(new_text)

def check(candidate):
    assert candidate('String matching is a big part of RexEx library.') == 'RES'

def test_check():
    check(f)

test_check()
