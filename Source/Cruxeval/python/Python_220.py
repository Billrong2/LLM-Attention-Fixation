def f(text: str, m: int, n: int) -> str:    
    text = "{}{}{}".format(text, text[:m], text[n:])
    result = ""
    for i in range(n, len(text)-m):
        result = text[i] + result
    return result

def check(candidate):
    assert candidate('abcdefgabc', 1, 2) == 'bagfedcacbagfedc'

def test_check():
    check(f)

test_check()
