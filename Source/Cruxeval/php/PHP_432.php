<?php
function f($length, $text) {
    if (strlen($text) == $length) {
        return strrev($text);
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(-5, "G5ogb6f,c7e.EMm") !== false) { throw new Exception("Test failed!"); }
}

test();
