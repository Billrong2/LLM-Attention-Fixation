<?php
function f($text) {
    try {
        return ctype_alpha($text);
    } catch (Exception $e) {
        return false;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("x") !== true) { throw new Exception("Test failed!"); }
}

test();
