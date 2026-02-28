<?php
function f($text, $char) {
    return ctype_lower($char) && ctype_lower($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abc", "e") !== true) { throw new Exception("Test failed!"); }
}

test();
