<?php
function f($text) {
    list($string_a, $string_b) = explode(',', $text);
    return -strlen($string_a) - strlen($string_b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dog,cat") !== -6) { throw new Exception("Test failed!"); }
}

test();
