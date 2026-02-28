<?php
function f($text, $n) {
    $length = strlen($text);
    return substr($text, $length * ($n % 4), $length);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abc", 1) !== "") { throw new Exception("Test failed!"); }
}

test();
