<?php
function f($text) {
    return !is_numeric($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("the speed is -36 miles per hour") !== true) { throw new Exception("Test failed!"); }
}

test();
