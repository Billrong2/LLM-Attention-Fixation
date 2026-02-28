<?php
function f($text) {
    foreach(str_split($text) as $c) {
        if (!is_numeric($c)) {
            return false;
        }
    }
    return (bool) $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("99") !== true) { throw new Exception("Test failed!"); }
}

test();
