<?php
function f($text, $search) {
    return strpos($search, $text, 0) === 0 ? true : false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("123", "123eenhas0") !== true) { throw new Exception("Test failed!"); }
}

test();
