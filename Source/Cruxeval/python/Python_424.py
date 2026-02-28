def f(s: str) -> str:    
    s = s.replace('"', '')
    lst = list(s)
    col = 0
    count = 1
    while col < len(lst) and lst[col] in ".:,":
        if lst[col] == ".":
            count = ls[col] + 1
        col += 1
    return s[col+count:]

def check(candidate):
    assert candidate('"Makers of a Statement"') == 'akers of a Statement'

def test_check():
    check(f)

test_check()
