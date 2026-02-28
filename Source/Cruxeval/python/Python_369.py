def f(var: str) -> str:    
    if var.isdigit():
        return "int"
    elif var.replace('.', '', 1).isdigit():
        return "float"
    elif var.count(' ') == len(var) - 1:
        return "str"
    elif len(var) == 1:
        return "char"
    else:
        return "tuple"

def check(candidate):
    assert candidate(' 99 777') == 'tuple'

def test_check():
    check(f)

test_check()
