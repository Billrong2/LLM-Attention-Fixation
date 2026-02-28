<?php
function f($text) {
    return !preg_match('/[A-Z]/', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("lunabotics") !== true) { throw new Exception("Test failed!"); }
}

test();
