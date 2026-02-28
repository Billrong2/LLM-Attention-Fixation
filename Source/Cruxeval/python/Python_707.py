def f(text: str, position: int) -> str:    
    length = len(text)
    index = position % (length + 1)
    if position < 0 or index < 0:
        index = -1
    new_text = list(text)
    new_text.pop(index)
    return ''.join(new_text)

def check(candidate):
    assert candidate('undbs l', 1) == 'udbs l'

def test_check():
    check(f)

test_check()
