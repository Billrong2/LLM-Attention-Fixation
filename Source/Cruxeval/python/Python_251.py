from typing import List

def f(messages: List[List[str]]) -> str:    
    phone_code = "+353"
    result = []
    for message in messages:
        message.extend(phone_code)
        result.append(";".join(message))
    return ". ".join(result)

def check(candidate):
    assert candidate([['Marie', 'Nelson', 'Oscar']]) == 'Marie;Nelson;Oscar;+;3;5;3'

def test_check():
    check(f)

test_check()
