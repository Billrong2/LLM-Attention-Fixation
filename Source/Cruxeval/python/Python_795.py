def f(text: str) -> str:    
    return text.title().replace('Io', 'io')

def check(candidate):
    assert candidate('Fu,ux zfujijabji pfu.') == 'Fu,Ux Zfujijabji Pfu.'

def test_check():
    check(f)

test_check()
