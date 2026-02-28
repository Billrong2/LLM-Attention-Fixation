<?php
function f($char) {
    if (strpos('aeiouAEIOU', $char) === false) {
        return null;
    }
    if (strpos('AEIOU', $char) !== false) {
        return strtolower($char);
    }
    return strtoupper($char);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("o") !== "O") { throw new Exception("Test failed!"); }
}

test();
