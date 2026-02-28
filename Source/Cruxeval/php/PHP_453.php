<?php
function f($string, $c) {
    return substr($string, -strlen($c)) === $c;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wrsch)xjmb8", "c") !== false) { throw new Exception("Test failed!"); }
}

test();
