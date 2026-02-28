def f(text: str) -> str:    
    for item in text.split():
        text = text.replace('-{}'.format(item), ' ').replace('{}-'.format(item), ' ')
    return text.strip('-')

def check(candidate):
    assert candidate('-stew---corn-and-beans-in soup-.-') == 'stew---corn-and-beans-in soup-.'

def test_check():
    check(f)

test_check()
