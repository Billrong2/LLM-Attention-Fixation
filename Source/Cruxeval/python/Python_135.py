from typing import List

def f() -> List[str]:    
    d = {
        'Russia': [('Moscow', 'Russia'), ('Vladivostok', 'Russia')],
        'Kazakhstan': [('Astana', 'Kazakhstan')],
    }
    return list(d.keys())

def check(candidate):
    assert candidate() == ['Russia', 'Kazakhstan']

def test_check():
    check(f)

test_check()
