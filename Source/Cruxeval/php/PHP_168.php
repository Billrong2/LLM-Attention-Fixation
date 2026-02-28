<?php
function f($text, $new_value, $index) {
    $key = strtr($text, $text[$index], $new_value);
    return $key;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("spain", "b", 4) !== "spaib") { throw new Exception("Test failed!"); }
}

test();
