<?php
function f($text, $char) {
    return strrpos($text, $char);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("breakfast", "e") !== 2) { throw new Exception("Test failed!"); }
}

test();
