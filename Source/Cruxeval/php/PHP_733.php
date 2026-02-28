<?php
function f($text) {
    $length = strlen($text) / 2;
    $left_half = substr($text, 0, $length);
    $right_half = strrev(substr($text, $length));
    return $left_half . $right_half;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("n") !== "n") { throw new Exception("Test failed!"); }
}

test();
