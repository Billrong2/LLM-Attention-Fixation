def f(text: str) -> str:    
    out = ""
    for i in range(len(text)):
        if text[i].isupper():
            out += text[i].lower()
        else:
            out += text[i].upper()
    return out

def check(candidate):
    assert candidate(',wPzPppdl/') == ',WpZpPPDL/'

def test_check():
    check(f)

test_check()
