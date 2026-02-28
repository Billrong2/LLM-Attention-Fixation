def f(text: str) -> str:    
    a = text.split('\n')
    b = []
    for i in range(len(a)):
        c = a[i].replace('\t', '    ')
        b.append(c)
    return '\n'.join(b)

def check(candidate):
    assert candidate('\t\t\ttab tab tabulates') == '            tab tab tabulates'

def test_check():
    check(f)

test_check()
