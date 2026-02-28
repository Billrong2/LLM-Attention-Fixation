<?php
function f($text, $start) {
    return substr($text, 0, strlen($start)) === $start;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Hello world", "Hello") !== true) { throw new Exception("Test failed!"); }
}

test();
