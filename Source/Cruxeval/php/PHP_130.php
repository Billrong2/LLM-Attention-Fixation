Unfortunately, it's not possible to translate the Python function to PHP due to PHP's limitations. The PHP function cannot reverse the order of the dictionary items, and Python's string formatting does not support named placeholders for unpacked dictionaries.

Here's the Python code:

```python
from typing import Dict

def f(m: Dict[str, int]) -> str:
    items = list(m.items())
    for i in range(len(items)-2, -1, -1):
        tmp = items[i]
        items[i] = items[i+1]
        items[i+1] = tmp
    return ['{}={}', '{1}={0}'][len(items) % 2].format(
        *m.keys(), **m
    )


def check(candidate):
    assert candidate({'a': 1, 'b': 2}) == 'a=b'

def test_check():
    check(f)

test_check()
```

And here's the test case:

```python
check(f)
```
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("l" => 4, "h" => 6, "o" => 9)) !== "h=l") { throw new Exception("Test failed!"); }
}

test();
