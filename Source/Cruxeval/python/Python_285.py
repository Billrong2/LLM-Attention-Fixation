def f(text: str, ch: str) -> int:    
    """Counting vowels in Pirates' Curse"""
    return text.count(ch)

def check(candidate):
    assert candidate("This be Pirate's Speak for 'help'!", ' ') == 5

def test_check():
    check(f)

test_check()
