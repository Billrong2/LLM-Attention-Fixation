def f(text: str) -> str:    
    t = 5
    tab = []
    for i in text:
        if i.lower() in 'aeiouy':
            tab.append(i.upper() * t)
        else:
            tab.append(i * t)
    return ' '.join(tab)

def check(candidate):
    assert candidate('csharp') == 'ccccc sssss hhhhh AAAAA rrrrr ppppp'

def test_check():
    check(f)

test_check()
