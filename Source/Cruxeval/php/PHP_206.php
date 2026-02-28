<?php
function f($a) {
    return implode(' ', array_filter(explode(' ', $a)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(" h e l l o   w o r l d! ") !== "h e l l o w o r l d!") { throw new Exception("Test failed!"); }
}

test();
