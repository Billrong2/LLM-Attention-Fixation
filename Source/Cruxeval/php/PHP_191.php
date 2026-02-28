<?php
function f($string) {
    if (strtoupper($string) === $string) {
        return true;
    } else {
        return false;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Ohno") !== false) { throw new Exception("Test failed!"); }
}

test();
