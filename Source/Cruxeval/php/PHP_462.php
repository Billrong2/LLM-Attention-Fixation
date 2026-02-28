<?php
function f($text, $value) {
    $length = strlen($text);
    $letters = str_split($text);
    if (!in_array($value, $letters)) {
        $value = $letters[0];
    }
    return str_repeat($value, $length);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ldebgp o", "o") !== "oooooooo") { throw new Exception("Test failed!"); }
}

test();
