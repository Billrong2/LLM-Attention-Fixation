def f(text: str) -> str:    
    return text[-1] + text[:-1]

def check(candidate):
    assert candidate('hellomyfriendear') == 'rhellomyfriendea'

def test_check():
    check(f)

test_check()
