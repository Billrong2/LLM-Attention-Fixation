<?php
function f($text, $char, $replace) {
    return str_replace($char, $replace, $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a1a8", "1", "n2") !== "an2a8") { throw new Exception("Test failed!"); }
}

test();
