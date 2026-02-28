def f(values: str, text: str, markers: str) -> str:    
    return text.rstrip(values).rstrip(markers)

def check(candidate):
    assert candidate('2Pn', 'yCxpg2C2Pny2', '') == 'yCxpg2C2Pny'

def test_check():
    check(f)

test_check()
