<?php
function f($mess, $char) {
    while (strpos($mess, $char, strrpos($mess, $char) + 1) !== false) {
        $mess = substr($mess, 0, strrpos($mess, $char) + 1) . substr($mess, strrpos($mess, $char) + 2);
    }
    return $mess;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("0aabbaa0b", "a") !== "0aabbaa0b") { throw new Exception("Test failed!"); }
}

test();
