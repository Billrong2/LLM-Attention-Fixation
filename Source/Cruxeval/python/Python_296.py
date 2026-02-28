def f(url: str) -> str:    
    return url.removeprefix('http://www.')

def check(candidate):
    assert candidate('https://www.www.ekapusta.com/image/url') == 'https://www.www.ekapusta.com/image/url'

def test_check():
    check(f)

test_check()
