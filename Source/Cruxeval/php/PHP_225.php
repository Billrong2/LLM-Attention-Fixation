<?php
function f($text) {
    if (ctype_lower($text)) {
        return true;
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("54882") !== false) { throw new Exception("Test failed!"); }
}

test();
