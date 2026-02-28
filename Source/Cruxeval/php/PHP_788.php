<?php
function f($text, $suffix) {
    if (strpos($suffix, '/') === 0) {
        return $text . substr($suffix, 1);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hello.txt", "/") !== "hello.txt") { throw new Exception("Test failed!"); }
}

test();
