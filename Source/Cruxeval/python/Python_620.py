def f(x: str) -> str:    
    return " ".join(list(x)[::-1])

def check(candidate):
    assert candidate('lert dna ndqmxohi3') == '3 i h o x m q d n   a n d   t r e l'

def test_check():
    check(f)

test_check()
