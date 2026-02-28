from typing import Dict, Union

def f(student_marks: Dict[str, int], name: str) -> Union[int, str]:    
    if name in student_marks:
        value = student_marks.pop(name)
        return value
    return 'Name unknown'

def check(candidate):
    assert candidate({ '882afmfp': 56 }, '6f53p') == 'Name unknown'

def test_check():
    check(f)

test_check()
