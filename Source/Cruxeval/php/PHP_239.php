<?php
function f($text, $froms) {
    $text = ltrim($text, $froms);
    $text = rtrim($text, $froms);
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("0 t 1cos ", "st 0	\n  ") !== "1co") { throw new Exception("Test failed!"); }
}

test();
