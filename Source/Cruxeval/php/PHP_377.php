<?php
function f($text) {
    return implode(', ', explode(PHP_EOL, $text));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("BYE\nNO\nWAY") !== "BYE, NO, WAY") { throw new Exception("Test failed!"); }
}

test();
