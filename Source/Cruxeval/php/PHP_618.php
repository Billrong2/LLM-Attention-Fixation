<?php
function f($match, $fill, $n) {
    return substr($fill, 0, $n) . $match;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("9", "8", 2) !== "89") { throw new Exception("Test failed!"); }
}

test();
