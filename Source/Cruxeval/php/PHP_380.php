<?php
function f($text, $delimiter) {
    $text = explode($delimiter, $text);
    return implode($delimiter, array_slice($text, 0, -1));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("xxjarczx", "x") !== "xxjarcz") { throw new Exception("Test failed!"); }
}

test();
