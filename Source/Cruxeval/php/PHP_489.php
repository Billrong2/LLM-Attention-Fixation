<?php
function f($text, $value) {
    return str_starts_with(strtolower($text), strtolower($value)) ? substr($text, strlen($value)) : $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("coscifysu", "cos") !== "cifysu") { throw new Exception("Test failed!"); }
}

test();
