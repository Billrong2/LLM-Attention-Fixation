def f(text: str, pre: str) -> str:    
    if not text.startswith(pre):
        return text
    return text.removeprefix(pre)

def check(candidate):
    assert candidate('@hihu@!', '@hihu') == '@!'

def test_check():
    check(f)

test_check()
