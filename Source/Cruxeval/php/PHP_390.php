<?php
function f($text) {
    if (empty(trim($text))) {
        return strlen(trim($text));
    }
    return null;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(" 	 ") !== 0) { throw new Exception("Test failed!"); }
}

test();
