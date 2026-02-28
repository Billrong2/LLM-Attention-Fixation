def f(text: str, use: str) -> str:    
    return text.replace(use, '')

def check(candidate):
    assert candidate('Chris requires a ride to the airport on Friday.', 'a') == 'Chris requires  ride to the irport on Fridy.'

def test_check():
    check(f)

test_check()
