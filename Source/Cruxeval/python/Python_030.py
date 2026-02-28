from typing import List, Union

def f(array: List[Union[str, int]]) -> List[Union[str, int]]:    
    result = []
    for elem in array:
        if elem.isascii() or (isinstance(elem, int) and not str(abs(elem)).isascii()):
            result.append(elem)
    return result

def check(candidate):
    assert candidate(['a', 'b', 'c']) == ['a', 'b', 'c']

def test_check():
    check(f)

test_check()
