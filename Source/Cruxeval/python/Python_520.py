from typing import List

def f(album_sales: List[int]) -> int:
    while len(album_sales) != 1:
        album_sales.append(album_sales.pop(0))
    return album_sales[0]

def check(candidate):
    assert candidate([6]) == 6

def test_check():
    check(f)

test_check()
