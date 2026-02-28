def f(address: str) -> str:    
    suffix_start = address.index('@') + 1
    if address[suffix_start:].count('.') > 1:
        address = address.removesuffix('.'.join(address.split('@')[1].split('.')[:2]))
    return address

def check(candidate):
    assert candidate('minimc@minimc.io') == 'minimc@minimc.io'

def test_check():
    check(f)

test_check()
