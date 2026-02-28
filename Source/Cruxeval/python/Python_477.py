from typing import Tuple

def f(text: str) -> Tuple[str, str]:    
    topic, sep, problem = text.rpartition('|')
    if problem == 'r':
        problem = topic.replace('u', 'p')
    return topic, problem

def check(candidate):
    assert candidate('|xduaisf') == ('', 'xduaisf')

def test_check():
    check(f)

test_check()
