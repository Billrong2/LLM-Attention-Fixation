from typing import List

def f(text: str, rules: List[str]) -> str:    
    for rule in rules:
        if rule == '@':
            text = text[::-1]
        elif rule == '~':
            text = text.upper()
        elif text and text[len(text)-1] == rule:
            text = text[0:len(text)-1]
    return text

def check(candidate):
    assert candidate('hi~!', ['~', '`', '!', '&']) == 'HI~'

def test_check():
    check(f)

test_check()
