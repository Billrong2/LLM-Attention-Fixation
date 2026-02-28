function test(): void {
    check(function() {
        return f(3);
    });
}
```

This will work the same as the previous version.
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(12) !== array(3, 4.5)) { throw new Exception("Test failed!"); }
}

test();
