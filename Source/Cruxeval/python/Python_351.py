def f(text: str) -> str:    
    try:
        while 'nnet lloP' in text:
            text = text.replace('nnet lloP', 'nnet loLp')
    finally:
        return text

def check(candidate):
    assert candidate('a_A_b_B3 ') == 'a_A_b_B3 '

def test_check():
    check(f)

test_check()
