<?php
function f($text) {
    if (ctype_alnum($text)) {
        return preg_replace('/\D/', '', $text);
    } else {
        return preg_replace('/\W/', '', $text);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("816") !== "816") { throw new Exception("Test failed!"); }
}

test();
