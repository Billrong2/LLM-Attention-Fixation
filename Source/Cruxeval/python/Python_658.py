from typing import Dict, List, Optional

def f(d: Dict[int, str], get_ary: List[int]) -> List[Optional[str]]:    
    result = []
    for key in get_ary:
        result.append(d.get(key))
    return result

def check(candidate):
    assert candidate({ 3: 'swims like a bull' }, [3, 2, 5]) == ['swims like a bull', None, None]

def test_check():
    check(f)

test_check()
