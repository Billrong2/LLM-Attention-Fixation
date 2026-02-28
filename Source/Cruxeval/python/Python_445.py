def f(names: str) -> str:    
    parts = names.split(',')
    for i, part in enumerate(parts):
        parts[i] = part.replace(' and', '+').title().replace('+', ' and')
    return ', '.join(parts)

def check(candidate):
    assert candidate('carrot, banana, and strawberry') == 'Carrot,  Banana,  and Strawberry'

def test_check():
    check(f)

test_check()
