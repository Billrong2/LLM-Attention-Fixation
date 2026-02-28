<?php
function f($text) {
    return substr_count($text, '-') === strlen($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("---123-4") !== false) { throw new Exception("Test failed!"); }
}

test();
