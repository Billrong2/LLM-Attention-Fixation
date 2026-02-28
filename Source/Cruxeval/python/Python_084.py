def f(text: str) -> str:    
    arr = text.split()
    result = []
    for item in arr:
        if item.endswith('day'):
            item += 'y'
        else:
            item += 'day'
        result.append(item)
    return ' '.join(result)

def check(candidate):
    assert candidate('nwv mef ofme bdryl') == 'nwvday mefday ofmeday bdrylday'

def test_check():
    check(f)

test_check()
