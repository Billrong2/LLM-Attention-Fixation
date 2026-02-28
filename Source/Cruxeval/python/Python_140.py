def f(st: str) -> str:
    if st.lower().rindex('h', st.lower().rindex('i')) >= st.lower().rindex('i'):
        return 'Hey'
    else:
        return 'Hi'

def check(candidate):
    assert candidate('Hi there') == 'Hey'

def test_check():
    check(f)

test_check()
