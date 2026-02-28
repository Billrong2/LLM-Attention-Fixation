def f(letters: str) -> str:    
    letters_only = letters.strip("., !?*")
    return "....".join(letters_only.split(" "))

def check(candidate):
    assert candidate('h,e,l,l,o,wo,r,ld,') == 'h,e,l,l,o,wo,r,ld'

def test_check():
    check(f)

test_check()
