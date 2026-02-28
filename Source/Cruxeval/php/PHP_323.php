<?php
function f($text) {
    return count(preg_split('/\r\n|\r|\n/', $text));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ncdsdfdaaa0a1cdscsk*XFd") !== 1) { throw new Exception("Test failed!"); }
}

test();
