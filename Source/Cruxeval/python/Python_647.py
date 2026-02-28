from typing import List

def f(text: str, chunks: int) -> List[str]:    
    return text.splitlines(chunks)

def check(candidate):
    assert candidate('/alcm@ an)t//eprw)/e!/d\nujv', 0) == ['/alcm@ an)t//eprw)/e!/d', 'ujv']

def test_check():
    check(f)

test_check()
