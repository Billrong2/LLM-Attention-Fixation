def f(text: str, width: int) -> str:    
    result = ""
    lines = text.split('\n')
    for l in lines:
        result += l.center(width)
        result += '\n'

    # Remove the very last empty line
    result = result[:-1]
    return result

def check(candidate):
    assert candidate('l\nl', 2) == 'l \nl '

def test_check():
    check(f)

test_check()
