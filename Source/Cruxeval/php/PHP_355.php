<?php
function f($text, $prefix) {
    return substr($text, strlen($prefix));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("123x John z", "z") !== "23x John z") { throw new Exception("Test failed!"); }
}

test();
