<?php
function f($text, $char) {
    return implode(' ', explode($char, $text));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a", "a") !== " ") { throw new Exception("Test failed!"); }
}

test();
