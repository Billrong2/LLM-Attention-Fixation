def f(text: str, prefix: str) -> str:    
    if text.startswith(prefix):
        text = text.removeprefix(prefix)
    text = text.capitalize()
    return text

def check(candidate):
    assert candidate('qdhstudentamxupuihbuztn', 'jdm') == 'Qdhstudentamxupuihbuztn'

def test_check():
    check(f)

test_check()
