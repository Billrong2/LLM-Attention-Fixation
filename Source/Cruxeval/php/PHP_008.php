<?php
function f($string, $encryption) {
    if ($encryption == 0) {
        return $string;
    } else {
        return str_rot13(strtoupper($string));
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("UppEr", 0) !== "UppEr") { throw new Exception("Test failed!"); }
}

test();
