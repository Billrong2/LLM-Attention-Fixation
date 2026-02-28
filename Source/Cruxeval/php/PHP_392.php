<?php
function f($text) {
    if (strtoupper($text) === $text) {
        return 'ALL UPPERCASE';
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Hello Is It MyClass") !== "Hello Is It MyClass") { throw new Exception("Test failed!"); }
}

test();
