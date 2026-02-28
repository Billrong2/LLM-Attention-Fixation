function f($text) {
    $text = str_replace(' ', "\t", $text, 1);
    return $text;
}
```

This function replaces the first space with a tab.
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("\n\n		z	d\ng\n			e") !== "\n\n        z   d\ng\n            e") { throw new Exception("Test failed!"); }
}

test();
