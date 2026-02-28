<?php
function f($test, $sep = ' ', $maxsplit = -1) {
    try {
        return explode($sep, $test, $maxsplit);
    } catch (Exception $e) {
        return explode(' ', $test);
    }
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ab cd", "x", 2) !== array("ab cd")) { throw new Exception("Test failed!"); }
}

test();
