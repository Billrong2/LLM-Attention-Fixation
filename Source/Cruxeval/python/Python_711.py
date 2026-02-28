def f(text: str) -> str:    
    return text.replace('\n', '\t')

def check(candidate):
    assert candidate('apples\n\t\npears\n\t\nbananas') == 'apples\t\t\tpears\t\t\tbananas'

def test_check():
    check(f)

test_check()
