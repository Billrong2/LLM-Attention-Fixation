<?php
function f($string) {
    if (strtoupper($string) === $string) {
        return strtolower($string);
    } elseif (strtolower($string) === $string) {
        return strtoupper($string);
    }
    return $string;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("cA") !== "cA") { throw new Exception("Test failed!"); }
}

test();
