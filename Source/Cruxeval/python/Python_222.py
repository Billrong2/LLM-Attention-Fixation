def f(mess: str, char: str) -> str:    
    while mess.find(char, mess.rindex(char) + 1) != -1:
        mess = mess[:mess.rindex(char) + 1] + mess[mess.rindex(char) + 2:]
    return mess

def check(candidate):
    assert candidate('0aabbaa0b', 'a') == '0aabbaa0b'

def test_check():
    check(f)

test_check()
