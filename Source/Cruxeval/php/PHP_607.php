<?php
function f($text) {
    foreach (['.', '!', '?'] as $i) {
        if (substr($text, -1) === $i) {
            return true;
        }
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(". C.") !== true) { throw new Exception("Test failed!"); }
}

test();
