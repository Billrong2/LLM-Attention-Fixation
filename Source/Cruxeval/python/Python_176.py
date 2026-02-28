def f(text: str, to_place: str) -> str:    
    after_place = text[:text.find(to_place, 0) + 1]
    before_place = text[text.find(to_place, 0) + 1:]
    return after_place + before_place

def check(candidate):
    assert candidate('some text', 'some') == 'some text'

def test_check():
    check(f)

test_check()
