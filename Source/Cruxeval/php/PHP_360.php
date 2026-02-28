<?php
function f($text, $n) {
    if (strlen($text) <= 2) {
        return $text;
    }
    $leading_chars = str_repeat($text[0], $n - strlen($text) + 1);
    return $leading_chars . substr($text, 1, -1) . $text[strlen($text) - 1];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("g", 15) !== "g") { throw new Exception("Test failed!"); }
}

test();
