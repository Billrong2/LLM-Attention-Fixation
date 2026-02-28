from typing import List

def f(test: str, sep: str = ' ', maxsplit: int = -1) -> List[str]:    
    try:
        return test.rsplit(sep, maxsplit)
    except:
        return test.rsplit()

def check(candidate):
    assert candidate('ab cd', 'x', 2) == ['ab cd']

def test_check():
    check(f)

test_check()
