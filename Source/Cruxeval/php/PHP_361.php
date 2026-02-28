<?php
function f($text) {
    return substr_count(explode(':', $text)[0], '#');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("#! : #!") !== 1) { throw new Exception("Test failed!"); }
}

test();
