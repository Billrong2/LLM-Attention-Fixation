def f(text: str) -> int:    
    return len(text) - text.count('bot')

def check(candidate):
    assert candidate('Where is the bot in this world?') == 30

def test_check():
    check(f)

test_check()
