import re
from typing import Dict,List

def f(out: str, mapping: Dict[str, List[str]]) -> str:    
    for key in mapping:
        out.format_map(mapping)
        if len(re.findall(r'{\w}', out)) == 0:
            break
        mapping[key][1] = mapping[key][1][::-1]
    return out

def check(candidate):
    assert candidate('{{{{}}}}', {  }) == '{{{{}}}}'

def test_check():
    check(f)

test_check()
