def f(name: str) -> str:    
    new_name =''
    name = name[::-1]
    for i in range(len(name)):
        n = name[i]
        if n !='.' and  new_name.count('.')<2:
            new_name=n+new_name
        else:
            break
    return new_name

def check(candidate):
    assert candidate('.NET') == 'NET'

def test_check():
    check(f)

test_check()
