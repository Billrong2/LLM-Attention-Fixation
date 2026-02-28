<?php
function f($text) {
    if (ctype_digit($text)) {
        return 'yes';
    } else {
        return 'no';
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abc") !== "no") { throw new Exception("Test failed!"); }
}

test();
