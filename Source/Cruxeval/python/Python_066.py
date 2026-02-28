def f(text: str, prefix: str) -> str:    
    prefix_length = len(prefix)
    if text.startswith(prefix):
        return text[(prefix_length - 1) // 2:
                    (prefix_length + 1) // 2 * -1:-1]
    else:
        return text

def check(candidate):
    assert candidate('happy', 'ha') == ''

def test_check():
    check(f)

test_check()
