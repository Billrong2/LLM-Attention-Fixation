def f(filename: str) -> bool:    
    suffix = filename.split('.')[-1]
    f2 = filename + suffix[::-1]
    return f2.endswith(suffix)

def check(candidate):
    assert candidate('docs.doc') == False

def test_check():
    check(f)

test_check()
