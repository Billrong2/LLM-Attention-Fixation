<?php
function f($text) {
    $length = strlen($text);
    $half = intval($length / 2);
    $encode = substr($text, 0, $half);
    if (substr($text, $half) == utf8_encode($encode)) {
        return true;
    } else {
        return false;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bbbbr") !== false) { throw new Exception("Test failed!"); }
}

test();
