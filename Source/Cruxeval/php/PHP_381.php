<?php
function f($text, $num_digits) {
    $width = max(1, $num_digits);
    return str_pad($text, $width, '0', STR_PAD_LEFT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("19", 5) !== "00019") { throw new Exception("Test failed!"); }
}

test();
