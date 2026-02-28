def f(price: float, product: str) -> float:    
    inventory = ['olives', 'key', 'orange']
    if product not in inventory:
        return price
    else:
        price *=.85
        inventory.remove(product)
    return price

def check(candidate):
    assert candidate(8.5, 'grapes') == 8.5

def test_check():
    check(f)

test_check()
