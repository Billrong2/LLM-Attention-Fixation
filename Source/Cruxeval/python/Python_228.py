def f(text: str, splitter: str) -> str:    
    return splitter.join(text.lower().split())

def check(candidate):
    assert candidate('LlTHH sAfLAPkPhtsWP', '#') == 'llthh#saflapkphtswp'

def test_check():
    check(f)

test_check()
