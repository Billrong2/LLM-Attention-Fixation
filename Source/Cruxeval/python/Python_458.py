def f(text: str, search_chars: str, replace_chars: str) -> str:    
    trans_table = str.maketrans(search_chars, replace_chars)
    return text.translate(trans_table)

def check(candidate):
    assert candidate('mmm34mIm', 'mm3', ',po') == 'pppo4pIp'

def test_check():
    check(f)

test_check()
