<?php
function f($text, $value) {
    return str_pad($text, strlen($value), "?", STR_PAD_RIGHT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("!?", "") !== "!?") { throw new Exception("Test failed!"); }
}

test();
