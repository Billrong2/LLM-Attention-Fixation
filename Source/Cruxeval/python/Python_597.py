def f(s: str) -> str:    
    return s.upper()

def check(candidate):
    assert candidate('Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1') == 'JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1'

def test_check():
    check(f)

test_check()
