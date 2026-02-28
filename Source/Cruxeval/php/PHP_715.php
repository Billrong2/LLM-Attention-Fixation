<?php
function f($text, $char) {
    return substr_count($text, $char) % 2 !== 0;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abababac", "a") !== false) { throw new Exception("Test failed!"); }
}

test();
