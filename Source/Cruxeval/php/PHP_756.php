<?php
function f($text) {
    if (ctype_alnum($text) && ctype_digit($text)) {
        return 'integer';
    }
    return 'string';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("") !== "string") { throw new Exception("Test failed!"); }
}

test();
