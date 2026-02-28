<?php
function f($text) {
    foreach (str_split($text) as $char) {
        if (!ctype_space($char)) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("     i") !== false) { throw new Exception("Test failed!"); }
}

test();
