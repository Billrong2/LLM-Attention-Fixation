<?php
function f($text, $lower, $upper) {
    return preg_match('/[^\x20-\x7F]/', substr($text, $lower, $upper - $lower)) === 0;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("=xtanp|sugv?z", 3, 6) !== true) { throw new Exception("Test failed!"); }
}

test();
